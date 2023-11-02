class ConfigClass:
    def __init__(self, site_url="", gmail="", app_password="", api_host="", basic_token="", sale_demo_domain="", shorten_url=""):
        self.site_url = site_url
        self.gmail = gmail
        self.app_password = app_password
        self.api_host = api_host
        self.basic_token = basic_token
        self.sale_demo_domain = sale_demo_domain
        self.shorten_url = shorten_url

    def get_site_url(self):
        return self.site_url

    def set_site_url(self, site_url):
        self.site_url = site_url

    def get_gmail(self):
        return self.gmail

    def set_gmail(self, gmail):
        self.gmail = gmail

    def get_app_password(self):
        return self.gmail

    def set_app_password(self, app_password):
        self.app_password = app_password

    def set_api_host(self, api_host):
        self.api_host = api_host

    def get_basic_token(self):
        return self.basic_token

    def set_basic_token(self, basic_token):
        self.basic_token = basic_token

    def set_sale_demo_domain(self, sale_demo_domain):
        self.sale_demo_domain = sale_demo_domain

    def get_sale_demo_domain(self):
        return self.sale_demo_domain

    def set_shorten_url(self, shorten_url):
        self.shorten_url = shorten_url

    def get_shorten_url(self):
        return self.shorten_url
