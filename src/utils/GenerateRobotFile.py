from src.utils.ExcelLibReader import ExcelLibReader
from shutil import copyfile
import logging
import pandas as pd
import os


class GenerateRobotFile:

    def copy_template_into_newfile(self, test_name):
        path_file = '../tests/' + test_name + ".robot"
        template_path_file = '../../resources/template_robot.robot'
        new_file_gen = open(path_file, "w+")
        new_file_gen.close()
        copyfile(template_path_file, path_file)
        return path_file

    def append_new_line(self, file_name, text_to_append):
        """Append given text as a new line at the end of file"""
        # Open the file in append & read mode ('a+')
        with open(file_name, "a+") as file_object:
            # Move read cursor to the start of file.
            file_object.seek(0)
            # If file is not empty then append '\n'
            data = file_object.read(100)
            if len(data) > 0:
                file_object.write("\n")
            # Append text at the end of file
            file_object.write(text_to_append)

    def genRobotFile(self, excel_file):
        # Use Pandas to rewrite the test case design file.
        # Just keep 5 columns: Key, Name, Precondition, Test Script - Step, Expected Result
        df = pd.read_excel(excel_file, usecols=[0, 1, 3, 13, 15])
        # Add text 'end' to the last row.
        new_row = ['' for i in range(df.shape[1])]
        new_row[0] = 'end'
        df.loc[df.shape[0]] = new_row
        df.to_excel(excel_file, sheet_name=os.path.basename(excel_file)[0:-5], index=False)
        test_suites = ExcelLibReader().read_all_sheet(excel_file)
        if test_suites:
            try:
                for testsuite in test_suites:
                    test_name = testsuite.get_name()
                    new_file_path = self.copy_template_into_newfile(test_name)
                    new_file_gen = open(new_file_path, "a")
                    new_file_gen.write('*** Test Cases ***' + "\n")
                    for testcase in testsuite.get_testcase_list():
                        new_file_gen.write("\n\n")
                        new_file_gen.write(testcase.get_name() + " (" + testcase.get_id() + ")" + "\n")
                        preconditions = self.get_break_down_string_with_split_text(testcase.get_precondition())
                        if preconditions:
                            for text_pre_item in preconditions:
                                if text_pre_item is not "":
                                    text_pre_item = text_pre_item.replace("\n", "")
                                    new_file_gen.write("\t" + text_pre_item + "\n")
                        # first step is setup test
                        new_file_gen.write("\t" + "Given Setup test" + "\n")
                        steps = testcase.get_steps()
                        for step in steps:
                            # show line of name of step same as line data test
                            text_append = "\t" + self.replace_step_number_to_when_condition(step.get_name())
                            if "\n" in text_append:
                                text_append = text_append.replace("\n", "")
                            if step.get_data_test() is not "" or step.get_data_test() is not None:
                                text_append = text_append + "\t\t" + step.get_data_test()
                            text_append = text_append + "\n"
                            print(text_append)
                            new_file_gen.write(text_append)
                            if step.get_expected_result() is not "" or step.get_expected_result() is not None:
                                text_expecteds = self.get_break_down_string_with_split_text(step.get_expected_result())
                                if text_expecteds:
                                    count_expecteds = 1
                                    text_expected_row = ""
                                    for text_item in text_expecteds:
                                        if count_expecteds == 1:
                                            text_expected_row = "\tThen " + text_item.strip() + "\n"
                                        elif text_item is not "":
                                            text_expected_row = "\tAnd " + text_item.strip() + "\n"
                                        new_file_gen.write(text_expected_row)
                                        count_expecteds += 1
                    new_file_gen.close()
            except IOError:
                print("can not generate test file")
                logging.exception("message")

    def get_break_down_string_with_split_text(self, texts):
        if texts is not None and texts is not "":
            texts = texts.replace("\n", "").strip()
            if texts.find("-") == -1:
                text_array = [texts]
                return text_array
            else:
                texts_array = texts.split("-")
                if "" in texts_array:
                    texts_array.remove("")
                    return texts_array
                else:
                    return texts.split("-")
        else:
            return None

    def get_text_and_separate_symbol(self, text_values, default_value):
        text_results = default_value
        for pre in text_values:
            if pre:
                text_results = text_results + pre + ","
        return text_results

    def replace_step_number_to_when_condition(self, step_name):
        text_array = step_name.split(".")
        print(text_array)
        print(len(text_array))
        return "when " + text_array[len(text_array) - 1].strip()


filePath = '../../resources/tests_excel/event_tests.xlsx'
GenerateRobotFile().genRobotFile(filePath)
