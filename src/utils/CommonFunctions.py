from robot.libraries.BuiltIn import BuiltIn
import json

class CommonFunctions:
    def __init__(self):
        self.company_site_url_path = 'resources/company_site_url.json'
        self.company_name_path = 'resources/company_name.json'
        self.company_redirect_link_path = 'resources/company_redirect_link.json'
        self.env_name = BuiltIn().get_variable_value("${env}")


    def get_company_site_link(self, company_name):
        # Get data from ENV
        file_stream = open(self.company_site_url_path)
        env_data = json.load(file_stream)[self.env_name]
        file_stream.close()
        return env_data[company_name]


    def get_company_franchise_on_site(self):
        default_env = ['LOWES_STG', 'MCHIRE', 'LTS_STG']
        return "/co/TestAutomationFranchiseOn1" if self.env_name in default_env else "/co/TestAutomationFranchiseOn"


    def get_company_redirect_url(self, company_name):
        '''
        @company_name: `Test Automation Franchise On`, `Test Automation Franchise Off`, ...
        '''
        try:
            default_url = "/login"
            # Init Company Name object
            file_stream = open(self.company_name_path)
            c_name_object = json.load(file_stream)
            file_stream.close()
            # Init Company Redirect link object
            file_stream = open(self.company_redirect_link_path)
            c_link_object = json.load(file_stream)[self.env_name]
            file_stream.close()
            for company_key, value in c_name_object.items():
                if company_name == value:
                    return default_url if not c_link_object[company_key] else c_link_object[company_key]
            return default_url
        except:
            return default_url
