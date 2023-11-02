import re


class StringHandler:
    def __init__(self):
        self.number_patten = r'\d+'
        self.number_separator = r','


    def extract_numbers(self, string):
        return re.findall(self.number_patten, string.replace(self.number_separator, ''))


    def get_short_name(self, fullname):
        username = fullname.split()
        short_name = ''
        for i in username:
            short_name += i[0].upper()

        return short_name
