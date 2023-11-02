import re
from robot.libraries.BuiltIn import BuiltIn
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

class PySelenium:
    def __init__(self):
        self.locator_regex_pattens = "^\(*?\/\/|^dom:|^id:"
        self.wait_time = 30
        self.loading_icon_1 = "//*[contains(@class,'la-ball-scale-multiple')]"
        self.loading_icon_2 = "//div[contains(@data-testid, 'loading_wrapper') and not(contains(@style,'display'))]"
        self.loading_icon_3 = "//div[@data-testid='loading_spinner']"
        self.loading_progress_1 = "//div[@class='nuxt-progress']"
        self.loading_progress_2 = "//*[contains(@class,'el-loading-parent')]"
        self.loading_progress_3 = "//*[@data-server-rendered='true']"
        self.loading_progress_4 = "//*[contains(@class,'ai-loading')]"


    def init_driver(self):
        return BuiltIn().get_library_instance('SeleniumLibrary').driver


    def identify_locator(self, locator):
        locator_prefix = re.findall(self.locator_regex_pattens, locator)[0]
        using_by = By.XPATH
        match locator_prefix:
            case "dom:":
                using_by = 'By.SHADOW_ROOT'
                locator = re.sub(self.locator_regex_pattens, "", locator)
            case "id:":
                using_by = By.ID
                locator = re.sub(self.locator_regex_pattens, "", locator)
        return {'using_by': using_by, 'locator': locator}


    def wait_for_element_disappear(self, driver, locator):
        identified = self.identify_locator(locator)
        return WebDriverWait(driver, self.wait_time).until(EC.invisibility_of_element_located((identified['using_by'], identified['locator'])))


    def wait_element_visible(self, locator):
        try:
            driver = self.init_driver()
            identified = self.identify_locator(locator)
            return WebDriverWait(driver, self.wait_time).until(EC.visibility_of_element_located((identified['using_by'], identified['locator'])))
        except Exception as e:
            raise Exception(e, locator)


    def wait_for_loading_icon_disappear(self, driver=None):
        driver = self.init_driver() if driver == None else driver
        driver.implicitly_wait(0)
        self.wait_time = 240
        self.wait_for_element_disappear(driver, self.loading_progress_1)
        self.wait_for_element_disappear(driver, self.loading_progress_2)
        self.wait_for_element_disappear(driver, self.loading_progress_3)
        self.wait_for_element_disappear(driver, self.loading_progress_4)
        self.wait_for_element_disappear(driver, self.loading_icon_1)
        self.wait_for_element_disappear(driver, self.loading_icon_2)
        self.wait_for_element_disappear(driver, self.loading_icon_3)
        driver.implicitly_wait(5)
        self.wait_time = 30


    def check_argument_is_locator(self, argument):
        locator_prefix = re.findall(self.locator_regex_pattens, argument)
        return len(locator_prefix) > 0


    def wait_element_clickable(self, locator):
        try:
            driver = self.init_driver()
            identified = self.identify_locator(locator)
            self.wait_for_loading_icon_disappear()
            if identified['using_by'] == 'By.SHADOW_ROOT':
                js_script = f"return {identified['locator']}"
                element = driver.execute_script(js_script)
                WebDriverWait(driver, self.wait_time).until(EC.element_to_be_clickable(element))
            else:
                element = WebDriverWait(driver, self.wait_time).until(EC.visibility_of_element_located((identified['using_by'], identified['locator'])))
                if not element.is_displayed():
                    # scrollIntoView(false) - the bottom of the element will be aligned to the bottom of the visible area of the scrollable ancestor.
                    driver.execute_script("arguments[0].scrollIntoView(false);", element)
                    ActionChains(driver).move_to_element(element).perform()
                WebDriverWait(driver, self.wait_time).until(EC.element_to_be_clickable((identified['using_by'], identified['locator'])))
        except Exception as e:
            raise Exception(e, locator)


    def scroll_by_js(self, locator):
        driver = self.init_driver()
        identified = self.identify_locator(locator)
        self.wait_for_loading_icon_disappear()
        element = WebDriverWait(driver, self.wait_time).until(EC.visibility_of_element_located((identified['using_by'], identified['locator'])))
        driver.execute_script("return arguments[0].scrollIntoView(true);", element)
        ActionChains(driver).move_to_element(element).perform()


    def py_click(self, locator):
        try:
            driver = self.init_driver()
            # Click element
            identified = self.identify_locator(locator)
            WebDriverWait(driver, self.wait_time).until(EC.element_to_be_clickable((identified['using_by'], identified['locator']))).click()
        except Exception as e:
            raise Exception(e, locator)


    def wait_shadow_root_conversation_fully_load(self):
        try:
            driver = self.init_driver()
            root_widget_locator = 'apply-widget'
            shadow_conversation_locator = "[data-testid='widget_chatbox_popover'']"
            root = driver.find_element(By.CSS_SELECTOR, root_widget_locator)
            shadow_root = driver.execute_script("return arguments[0].shadowRoot", root)
            WebDriverWait(driver, self.wait_time).until(EC.visibility_of(shadow_root.find_element(By.CSS_SELECTOR, shadow_conversation_locator)))
        except:
            return 'Nothing happened!'
