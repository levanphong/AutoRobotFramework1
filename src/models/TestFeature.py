class TestFeature:
    def __init__(self, name="", testcase_list=None):
        self.name = name
        self.testcase_list = testcase_list

    def get_name(self):
        return self.name

    def get_testcase_list(self):
        return self.testcase_list

    def set_name(self, name):
        self.name = name

    def set_testCase_list(self, testcase_list):
        self.testcase_list = testcase_list