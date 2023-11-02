import calendar
import time
import random
import string
from datetime import datetime, timedelta


class CandidateTest:
    def generate_candidate_info(self, location_id, email):
        candidate_info = {
            'candidateId': str(calendar.timegm(time.gmtime())),
            'storeId': location_id,
            'email': self.random_test_email_characters(email),
            'candidateName': self.random_name_characters('Test Candidate'),
            'homePhone': '+16462662537',
            'startDate': (datetime.today() - timedelta(days=1)).strftime('%Y-%m-%d'),
            'emailRecruiter': self.random_test_email_characters(email),
        }
        return candidate_info

    def random_test_email_characters(self, email):
        domain_index = email.find('@paradox.ai')
        return email[:domain_index] + '+' + ''.join(random.choice(string.ascii_uppercase + string.digits) for x in range(5)) + email[domain_index:]

    def random_name_characters(self, name):
        return name + '+' + ''.join(random.choice(string.ascii_uppercase + string.digits) for x in range(5))

    def make_info_from_xml(self, xml_path, candidate_info):
        content = []
        with open(xml_path, "r") as file:
            content = file.readlines()
            content = "".join(content) % (candidate_info['candidateId'], candidate_info['storeId'], candidate_info['email'], candidate_info['candidateName'].split()[0], candidate_info['candidateName'].split()[1], candidate_info['homePhone'], candidate_info['startDate'], candidate_info['emailRecruiter'])
        return content
