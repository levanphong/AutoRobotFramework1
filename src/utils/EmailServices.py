import email
import imaplib
import re
import time
import json
from robot.libraries.BuiltIn import BuiltIn


class EmailServices:
    def __init__(self):
        self.mail = None
        self.environment_path = 'resources/environments.json'
        self.default_host = 'imap.gmail.com'
        # Get ENV
        self.env_name = BuiltIn().get_variable_value("${env}")
        # Get data from ENV
        file_stream = open(self.environment_path)
        self.env_data = json.load(file_stream)[self.env_name]
        file_stream.close()


    def login_to_mail_server(self):
        self.mail = imaplib.IMAP4_SSL(self.default_host)
        # Login to Mail server
        self.mail.login(self.env_data["gmail"], self.env_data["app_password"])


    def get_email_list(self, content, mailbox):
        mailbox = 'INBOX' if mailbox is None else mailbox
        self.mail.select(mailbox)
        _, selected_mails = self.mail.search(None, f'BODY "{content}" (UNSEEN)')
        return selected_mails[0].split()[::-1]


    def get_email_data(self, subject, content, mailbox):
        return_object = {"is_email_exist": False, "email_message": ""}
        email_list = self.get_email_list(content, mailbox)
        for num in email_list:
            _, data = self.mail.fetch(num, '(RFC822)')
            _, bytes_data = data[0]
            email_message = email.message_from_bytes(bytes_data)
            if subject in re.sub("\r\n|\r|\n", "", email_message["subject"]).strip():
                return_object["is_email_exist"] = True
                return_object["email_message"] = email_message
                break
        return return_object


    def get_email_data_for_sure(self, subject, content, mailbox=None):
        self.login_to_mail_server()
        # Try to search email 3 times before return data
        email_data = self.get_email_data(subject, content, mailbox)
        if email_data["is_email_exist"] == False:
            for i in range(3):
                time.sleep(10)
                email_data = self.get_email_data(subject, content, mailbox)
                if email_data["is_email_exist"] == True:
                    email_data["retries"] = i+1
                    break
        return email_data


    def check_email_exist(self, subject, content, mailbox=None):
        email_data = self.get_email_data_for_sure(subject, content, mailbox)
        return email_data["is_email_exist"]


    def get_link_in_email(self, subject, content, custom_url=None, mailbox=None):
        email_data = self.get_email_data_for_sure(subject, content, mailbox)
        if email_data["is_email_exist"] == False:
            return ''
        base_url = self.env_data["siteURL"]
        custom_url = self.env_data["shortenURL"] # To get shorten URL (e.g: 'https://oli.vi' instead of 'https://olivia.paradox.ai')
        regex_url = base_url if custom_url is None or not custom_url else f'{base_url}|{custom_url}'
        link_regex_pattern = f'href=\"(?:{regex_url})(.*?)\"'
        if email_data["email_message"].is_multipart():
            for part in email_data["email_message"].walk():
                # Content type can be: 'multipart/alternative', 'text/plain', 'text/html', ... Only care about 'text/html'
                if part.get_content_type() == "text/html":
                    match_values = re.findall(link_regex_pattern, str(part.get_payload()))
                    if match_values:
                        return match_values
                    else:
                        return ''


    def get_verify_code(self, subject, content, separator=None, mailbox=None):
        email_data = self.get_email_data_for_sure(subject, content, mailbox)
        if email_data["is_email_exist"] == False:
            return ''
        code_separator =  " .-" if separator is None else separator
        code_regex_pattern = f'\(?([0-9]{{3}})\)?([{code_separator}])([0-9]{{3}}[ ]?)' # Code format: 123-456, 123 456, 123.456
        for payload in email_data["email_message"].get_payload():
            match_values = re.findall(code_regex_pattern, str(payload.get_payload()).strip())
            if match_values:
                return str(match_values[0]).replace(",", "").replace("(", "").replace(")", "").replace(" ", "").replace("'", "")
        return ''
