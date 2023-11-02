import json
import logging
import os

from ConfigClass import ConfigClass

class LoadConfig:

    def load_config_file(self, environment="STG"):
        try:
            directory = os.getcwd()
            logging.log(logging.INFO, directory)
            file_json = open(directory + '/resources/environments.json')
            data = json.load(file_json)
            file_json.close()
            data_env = data[environment]
            gmail = data_env["gmail"]
            app_password = data_env["app_password"]
            url = data_env["siteURL"]
            api_host = data_env["apiHost"]
            basic_token = data_env["basicToken"]
            sale_demo_domain = data_env["saleDemoDomain"]
            shorten_url = data_env["shortenURL"]
            logging.log(logging.INFO, file_json)
            logging.log(logging.INFO, gmail)
            config_instance = ConfigClass(url, gmail, app_password, api_host, basic_token, sale_demo_domain, shorten_url)
            print(config_instance.get_gmail())
            return config_instance
        except Exception:
            print(" we got an error")
            logging.log(logging.INFO, "can not parse")
            return None
