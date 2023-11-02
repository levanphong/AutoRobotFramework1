import json


class AppProperties:
    def __init__(self):
        self.environment_path = 'resources/environments.json'

    def get_environment_data(self, environment):
        f = open(self.environment_path)
        data = json.load(f)
        f.close()
        return data[environment]
