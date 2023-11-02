class MessageGmail:
    def __init__(self, subject, from_email, to_email, content):
        self.subject = subject
        self.content = content
        self.from_email = from_email
        self.to_email = to_email

    def get_subject(self):
        return self.subject

    def get_content_body(self):
        return self.content

    def get_from(self):
        return self.from_email

    def get_to(self):
        return self.to_email
