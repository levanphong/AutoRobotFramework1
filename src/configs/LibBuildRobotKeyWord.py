from robot.libraries.BuiltIn import BuiltIn
from LoadConfig import LoadConfig
from src.constants.PageLinks import EVENT, CLIENT_SETUP
from src.constants.UserRoles import PARADOX_ADMIN


class LibBuildRobotKeyWord:

    def get_config(self, env):
        config = LoadConfig().load_config_file(env)
        BuiltIn().set_suite_variable("${CONFIG}", config)
        return config

    def get_email(self, username):
        if PARADOX_ADMIN in username:
            email = "olivia.automation@paradox.ai"
        else:
            email = "thu.tran@parox.ai"
        return email

    def get_page_link(self, base_url, key_page):
        key_page = str(key_page).lower()
        sub_link = ""
        if "event" in key_page:
            sub_link = EVENT
        elif "client" in key_page:
            sub_link = CLIENT_SETUP
        result = base_url + sub_link
        return result

    def find_and_load_locator(self, locator_name):
        locator_name = str(locator_name).replace(" ", "_").upper()
        from src import locators
        locator_modules = dir(locators)
        result = ""
        for item in locator_modules:
            if type(item) is str and "_locator" in item:
                module = getattr(locators, item)
                object = getattr(module, locator_name, "")
                if object != "":
                    result = object
                    break
        print(result)
        return result

