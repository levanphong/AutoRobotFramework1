#My Calendar
ICON_MOVE_NEXT_WEEK_LOCATOR = "//div[contains(@class,'calendar-header')]//i[contains(@class,'icon icon-chevron-right')]"
SELECT_TIME_LOCATOR = "//*[contains(@data-time,':00')]"
START_HOUR_DROPDOWN = "//select[@id='start_hour']"
END_HOUR_DROPDOWN = "//select[@id='end_hour']"
SAVE_CALENDAR_BUTTON = "//button[contains(@class,'btn btn-primary btn-save-calendar')]"
ALL_TIME_SELECTED_LOCATOR = "//a[contains(@class,'fc-time-grid-event fc-v-event fc-event fc-start fc-end fc-draggable fc-resizable')]"
ALL_TIME_SELECTED_LOCATOR_BY_INDEX = "(//a[contains(@class,'fc-time-grid-event fc-v-event fc-event fc-start fc-end fc-draggable fc-resizable')])[{}]"
DELETE_TIME_BUTTON = "//button[contains(@class,'btn btn-transparent btn-delete')]"

BUSY_TIME_BLOCK = "(//td[contains(@data-date, '{}')]//div[contains(@class, 'fc-timegrid-bg-harness') and contains(., 'Hiring Event')]//parent::div[contains(@class, 'fc-timegrid-col-bg')]//div[contains(@class, 'fc-event')])[1]"
BUSY_TIME_BLOCK_OVERLAP = "//td[contains(@data-date, '{}')]//div[contains(@class, 'fc-timegrid-bg-harness') and contains(., 'Hiring Event')]"
VIEW_MY_EVENT_SCHEDULE_BUTTON = "//button[contains(@class, 'el-button') and contains(., 'View My Event Schedule')]"
TIME_BLOCK_REMAINING_MORNING = "(//td[contains(@data-date, '{}')]//div[contains(text(), 'Available for Interviews')])[2]//parent::div//parent::div[contains(@class, 'fc-time')]//span"
