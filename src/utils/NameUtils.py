import datetime
import os
import random
import string
from pathlib import Path


class NameUtils:

    def get_auto_name(self, name):
        random_string = ''
        for _ in range(10):
            # Considering only upper and lowercase letters
            random_integer = random.randint(97, 97 + 26 - 1)
            flip_bit = random.randint(0, 1)
            # Convert to lowercase if the flip bit is on
            random_integer = random_integer - 32 if flip_bit == 1 else random_integer
            # Keep appending random characters using chr(x)
            random_string += (chr(random_integer))

        print(random_string, len(random_string))
        return "{}{}".format(name, random_string)

    def get_path_upload_image_path(self, file_name):
        directory = os.getcwd() + '/resources/images/'
        for file in os.listdir(directory):
            if file_name in file:
                return os.path.join(directory, file)

    def get_path_upload_video_path(self, file_name):
        directory = '/opt/resources/videos/'
        for file in os.listdir(directory):
            if file_name in file:
                return os.path.join(directory, file)

    def get_path_upload_csv(self, file_name):
        directory = os.getcwd() + '/resources/csv_files/'
        for file in os.listdir(directory):
            if file_name in file:
                return os.path.join(directory, file)

    def uppercase_text_list(self, list_text):
        for text in list_text:
            text = str(text).replace(" ", "_").upper()
            print(text)

    def get_auto_candidate(self, name):
        random_string = self.get_random_text(5)
        return "{} {}".format(name, random_string.upper().capitalize())

    def get_random_text(self, number):
        letters = string.ascii_lowercase
        return ''.join(random.choice(letters) for i in range(number))

    def get_auto_email(self):
        ts = datetime.datetime.now().timestamp()
        print(ts)
        random_text = self.get_random_text(3) + str(ts)[-3:]
        return "test1+{}@paradox.ai".format(random_text)

    def get_path_driver(self, version):
        directory = os.getcwd()
        if 'Default' in version or '99' in version:
            return directory + '/resources/drivers/chromedriver'
        elif 'lower_99' in version:
            return directory + '/resources/drivers/chromedriver_lower_99'
        return directory + '/resources/drivers/chromedriver_' + version

    def get_path_screenshot(self):
        directory = os.getcwd()
        dir_path = directory + '/results/screenshots'
        directory_screenshot = os.path.dirname(dir_path)
        if not os.path.exists(directory_screenshot):
            os.makedirs(directory_screenshot)
        return dir_path

    def get_report_path(self):
        directory = os.getcwd()
        return directory + '/results/reports'

    def get_path_upload_pdf_path(self, file_name):
        directory = os.getcwd()
        return directory + '/resources/pdf_files/{}.pdf'.format(file_name)

    def get_first_name(self, name):
        return str(name).split(" ")[0]

    def conver_string_to_list(self, word):
        lst = []
        for i in word:
            if i != "-":
                lst.append(i)
        return lst

    def get_download_path(self, file_name='None'):
        directory = str(Path.home() / 'Downloads')
        if file_name != 'None':
            return directory + f'/{file_name}'
        return directory

    def get_absolute_path(self, relative_path, file_name):
        directory = os.path.abspath(file_name)
        dic = directory.split(file_name)
        new_dic = dic[0] + relative_path + "/" + file_name
        return  new_dic
