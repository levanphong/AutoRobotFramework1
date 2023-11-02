import argparse
import logging
import os
import random
import shutil
import smtplib
import string
import zipfile
from datetime import datetime
from email.message import EmailMessage
from email.mime.image import MIMEImage
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from pydrive.auth import GoogleAuth
from pydrive.drive import GoogleDrive

from src.utils import IOAction
from src.utils.NameUtils import NameUtils


class ReportService:
    parent_dir = os.getcwd().replace("src/utils", "")
    logging.log(logging.INFO, parent_dir)
    if not parent_dir.endswith("/"):
        parent_dir = parent_dir + "/"

    def __init__(self):
        self.username = ""
        self.app_pass = ""

    def set_account(self, username, pass_app):
        self.username = username
        self.app_pass = pass_app

    def send_email_report(self, report_name, env, receivers):
        report_file = self.parent_dir + "results/report.html"
        report_output_file = self.parent_dir + "results/output.xml"
        report_log_file = self.parent_dir + "results/log.html"
        # Current date time in local system print(datetime.now())
        date = str(datetime.date(datetime.now())).replace("-", "_")
        report_label = str(report_name).replace(" ", "_")
        report_folder = "{}_{}_{}_{}".format(self.parent_dir + "results/reports/" + env, report_label, date,
                                             self.get_auto_name_file(10).upper())
        screenshot_folder = self.parent_dir + "results/screenshots"
        print(report_folder)
        print(report_file)
        if not os.path.exists(report_folder):
            os.makedirs(report_folder)
        list_file = [report_log_file, report_output_file, report_file, screenshot_folder]
        for file in list_file:
            if os.path.isdir(file):
                screen_shot_dir = "/screenshots"
                shutil.copytree(file, report_folder + screen_shot_dir)
            else:
                self.generate_report(file, report_folder)
        folder_path = report_folder
        zip_path = folder_path + ".zip"
        self.zip_directory(folder_path, zip_path)
        link_google = self.upload_google_drive(zip_path)
        print(link_google)
        image_path = self.open_report_html_and_screenshot()
        self.send_mail(link_google, image_path, env, report_name, receivers)

    @staticmethod
    def generate_report(path_file, folder_dir):
        shutil.copy(path_file, folder_dir)

    @staticmethod
    def zip_directory(folder_path, zip_path):
        with zipfile.ZipFile(zip_path, mode='w') as zipf:
            len_dir_path = len(folder_path)
            for root, _, files in os.walk(folder_path):
                for file in files:
                    file_path = os.path.join(root, file)
                    zipf.write(file_path, file_path[len_dir_path:])

    def upload_google_drive(self, path):
        try:
            gauth = GoogleAuth()
            token_path = "mycreds.json"
            gauth.LoadCredentialsFile(token_path)
            if gauth.credentials is None:
                # Authenticate if they're not there
                # This is what solved the issues:
                gauth.GetFlow()
                gauth.flow.params.update({'access_type': 'offline'})
                gauth.flow.params.update({'approval_prompt': 'force'})
                gauth.LocalWebserverAuth()
            elif gauth.access_token_expired:
                gauth.Refresh()
            else:
                gauth.Authorize()
            # Save the current credentials to a file
            # gauth.SaveCredentialsFile(token_path)
            drive = GoogleDrive(gauth)
            folder_id = "1XazyB_Hfm0D8SYMjP4JzaLytmiNAMuET"
            f = drive.CreateFile(
                {"parents": [{"kind": "drive#fileLink", "id": folder_id}], 'title': self.get_file_name(path)})
            f.SetContentFile(os.path.join(path, path))
            f.Upload()
            id_file = f.get("id")
            return "https://drive.google.com/file/d/" + id_file
        except Exception:
            logging.exception("message")

    @staticmethod
    def get_file_name(path):
        if not os.path.isdir(path):
            return os.path.splitext(os.path.basename(path))[0].split(".")[0]

    def open_report_html_and_screenshot(self, height=1920, width=1080):
        from selenium import webdriver
        chrome_version = IOAction.get_chrome_version()
        path_driver = NameUtils.get_path_driver(self, chrome_version).replace("src/utils/", "")
        link_report = self.parent_dir + "results/report.html"
        chrome_options = webdriver.ChromeOptions()
        chrome_options.add_argument('--headless')
        chrome_options.add_argument('--disable-gpu')
        chrome_options.add_argument('--no-sandbox')
        chrome_options.add_argument('--incognito')
        browser = webdriver.Chrome(path_driver, options=chrome_options)
        browser.set_window_size(height, width)
        browser.get("file:///" + link_report)
        image_name = self.get_auto_name_file(10)
        path_screenshot = self.parent_dir + "results/" + "{}.png".format(image_name)
        browser.save_screenshot(path_screenshot)
        browser.quit()
        return path_screenshot

    def send_mail(self, link_google, image_path, env, report_name, receivers):
        msg = EmailMessage()
        default_receiver = ["m0r5p8x3h4b4u0v3@aiolivia.slack.com"]
        receiver_list = default_receiver if not receivers else default_receiver + receivers
        msg['Subject'] = '[{}] {} Regression Report'.format(env, report_name)
        msg['From'] = self.username
        msg['To'] = receiver_list
        msg_body = "Hi guys,<br><br>We had just finished the automation test after build.<br><br>Please go to the link " \
                   "<a href=\"{}\" target=\"blank\"a>{}</a> to get the latest automation test report.<br><br>And this folder for all reports until now:" \
                   " <a href=\"https://drive.google.com/drive/u/3/folders/1XazyB_Hfm0D8SYMjP4JzaLytmiNAMuET\" target=\"blank\" a>" \
                   " https://drive.google.com/drive/u/3/folders/1XazyB_Hfm0D8SYMjP4JzaLytmiNAMuET</a>."
        msg_body = msg_body.format(link_google, link_google)
        msg_related = MIMEMultipart('related')
        msg_text = MIMEText(msg_body + '<br><br><img src="cid:image">', 'html')
        msg_related.attach(msg_text)
        fp = open(image_path, 'rb')
        msg_image = MIMEImage(fp.read())
        fp.close()
        msg_image.add_header('Content-ID', '<image>')
        msg_related.attach(msg_image)
        msg.set_content(msg_related)
        with smtplib.SMTP_SSL('smtp.gmail.com', 465) as smtp:
            smtp.login(self.username, self.app_pass)
            smtp.send_message(msg)
            smtp.quit()

    def get_auto_name_file(self, number):
        letters = string.ascii_lowercase
        return ''.join(random.choice(letters) for i in range(number))


parser = argparse.ArgumentParser(description='add argument.')
parser.add_argument("--report_name", help="Prints report name", default="Regression_Test")
parser.add_argument("--env", help="Prints report name", default="STG")
parser.add_argument('--receivers', nargs='+', help="Prints report name")
args = parser.parse_args()
report_name = args.report_name
env = args.env
receivers = args.receivers
print(report_name)
if report_name:
    report = ReportService()
    report.set_account("olivia.automation@paradox.ai", "ejvmakcpppsvqpjm")
    report.send_email_report(report_name, str(env).upper(), receivers)
