import os
import pandas as pd
import random as rd

class FileHandler:

    def read_header_title_csv(self, file_path):
        df = pd.read_csv(file_path)
        return df.columns.to_list()

    def is_empty_csv(self, file_path):
        df = pd.read_csv(file_path)
        return df.empty

    def get_random_area_code(self):
        file_path = os.getcwd() + '/resources/area_code.json'
        df = pd.read_json(file_path)
        rand_num = rd.randint(0, df.shape[0] - 1)
        return str(df.loc[rand_num, 'US'])
