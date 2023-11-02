class StepTest:
    def __init__(self, name="", data_test="", expected_result=""):
        self.name = name
        self.set_expected_result(expected_result)
        self.set_data_test(data_test)

    def get_name(self):
        return self.name

    def get_expected_result(self):
        return self.expected_result

    def get_data_test(self):
        return self.data_test

    def set_data_test(self, data_test):
        if data_test:
            self.data_test = data_test
        else:
            self.data_test = ""

    def set_expected_result(self, expected_result):
        if (expected_result is None):
            self.expected_result = ""
        else:
            self.expected_result = expected_result


