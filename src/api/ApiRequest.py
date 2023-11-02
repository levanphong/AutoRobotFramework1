from src.configs.AppProperties import AppProperties
from src.api.TokenHelper import TokenHelper
import requests


class ApiRequest:
    def __init__(self):
        self.app_properties = AppProperties()
        self.token_helper = TokenHelper()
        self.authorization = ''
        self.content_type = 'application/json'

    def make_post_candidate_orient_event(self, request_path, environment, request_body_str):
        environment_info = self.app_properties.get_environment_data(environment)
        end_point = environment_info['apiHost'] + request_path
        token = self.token_helper.get_token_orient_event(environment)
        self.authorization = token
        self.content_type = 'application/xml'
        return self.make_request_api("POST", end_point,  request_body_str)

    def make_request_api(self, method, end_point, payload_data):
        payload = payload_data
        '''
        Payload contain a string body or a dictionary values
        E.g: 
        payload = {
                    "Host": "www.mywbsite.fr",
                    "Connection": "keep-alive",
                    "Content-Length": 129,
                    "Origin": "https://www.mywbsite.fr",
                    "X-Requested-With": "XMLHttpRequest",
                    "User-Agent": "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.52 Safari/536.5",
                    "Content-Type": "application/json",
                    "Accept": "*/*",
                    "Referer": "https://www.mywbsite.fr/data/mult.aspx",
                    "Accept-Encoding": "gzip,deflate,sdch",
                    "Accept-Language": "fr-FR,fr;q=0.8,en-US;q=0.6,en;q=0.4",
                    "Accept-Charset": "ISO-8859-1,utf-8;q=0.7,*;q=0.3",
                }
        '''
        headers = {
            'Authorization': self.authorization,
            'Content-Type': self.content_type
        }
        response = requests.request(method, end_point, headers=headers, data=payload)
        return response.status_code
