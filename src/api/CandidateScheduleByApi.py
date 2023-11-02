from src.data_tests.CandidateTest import CandidateTest
from src.api.ApiRequest import ApiRequest

class CandidateScheduleByApi:
    def __init__(self):
        self.candidate_test = CandidateTest()
        self.api_request = ApiRequest()

    def create_candidate_by_api(self, environment, candidate_info):
        xml_path = 'resources/orient_schedule/candidate_schedule_api.xml'
        request_body_str = self.candidate_test.make_info_from_xml(xml_path, candidate_info)
        return self.api_request.make_post_candidate_orient_event("public/candidates", environment, request_body_str)

