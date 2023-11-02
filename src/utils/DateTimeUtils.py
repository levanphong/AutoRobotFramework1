from datetime import datetime, timedelta
from calendar import monthrange
import re
from time import time


class DateTimeUtils:
    def __init__(self):
        self.time_unit = r'AM|PM|\(|\)'


    def get_future_day_from_curent_date(self, day_from_current=1):
        next_date = datetime.today() + timedelta(days=int(day_from_current))
        result = next_date.strftime("%-d")
        return result


    def get_future_time_from_current_date(self, time_from_current=1):
        time = datetime.today() + timedelta(hours=int(time_from_current))
        result = time.strftime("%I:30 %p")
        return result


    def get_past_date(self, minus_date=1):
        # return date without leading 0
        return (datetime.now() - timedelta(minus_date)).strftime('%e').strip()


    def get_future_date(self, plus_date=1):
        # return date without leading 0
        return (datetime.now() + timedelta(plus_date)).strftime('%e').strip()


    def get_diffrent_minutes_from_time_slot(self, first_time, second_time):
        first_time = re.sub(self.time_unit, "", first_time)
        second_time = re.sub(self.time_unit, "", second_time)
        first_time_minutes = int(first_time.split(":")[0]) * 60 + int(first_time.split(":")[1])
        second_time_minutes = int(second_time.split(":")[0]) * 60 + int(second_time.split(":")[1])
        return second_time_minutes - first_time_minutes


    def get_start_date_event_session(self):
        current_month = datetime.now().strftime("%m")
        current_year = datetime.now().strftime("%Y")
        year = current_year if (current_month != '12') else (int(current_year) + 1)
        match current_month:
            case '01':
                month_in_string = 'February'
            case '02':
                month_in_string = 'March'
            case '03':
                month_in_string = 'April'
            case '04':
                month_in_string = 'May'
            case '05':
                month_in_string = 'June'
            case '06':
                month_in_string = 'July'
            case '07':
                month_in_string = 'August'
            case '08':
                month_in_string = 'September'
            case '09':
                month_in_string = 'October'
            case '10':
                month_in_string = 'November'
            case '11':
                month_in_string = 'December'
            case '12':
                month_in_string = 'January'
        return month_in_string + ' 1, ' + year


    def get_current_time(self):
        # current_time: 02:22 AM
        current_time = datetime.now().strftime("%I:%M %p")
        return current_time


    def get_current_date(self):
        current_day = datetime.now().strftime("%d")
        current_month = datetime.now().strftime("%B")
        current_year = datetime.now().strftime("%Y")
        return current_month + f' {current_day}, ' + current_year


    def get_future_date_in_string(self, date):
        current_month = datetime.now().strftime("%m")
        date_in_int = int(date)
        return f'{current_month}-0{date_in_int}' if date_in_int < 10 else f'{current_month}-{date_in_int}'


    def get_date(self, index=0):
        date = datetime.today()
        if index != 0:
            date = datetime.today() + timedelta(days=index)
        return str(date.strftime('%Y-%m-%d'))


    def get_date_with_month_in_full_string(self, index=0):
        date = datetime.today()
        if index != 0:
            date = datetime.today() + timedelta(days=index)
        return str(date.strftime('%B %-d, %Y'))


    def get_number_of_date_in_month(self):
        return monthrange(datetime.now().year, datetime.now().month)[1]


    def format_date_times_schedule_option_message(self, date_times, time_zone_name = 'MST (AZ)'):
        # ['Wednesday, Oct. 19th, 2022 9:50 AM', 'Wednesday, Oct. 19th, 2022 10:10 AM']
        # format to: Do any of these times work?Below times are in: MST (AZ)1. Wednesday, October 19 at 09:50 AM2. Wednesday, October 19 at 10:10 AMView additional times at #calendar-link
        msg = f'Do any of these times work?Below times are in: {time_zone_name}'
        date_times = dict(zip(range(1, len(date_times) + 1), date_times))
        for index, value in date_times.items():
            date_time_schedule_option = self.format_date_time_schedule_option(value)
            msg += f'{index}. {date_time_schedule_option}'
        msg += 'View additional times at #calendar-link'
        return msg
            

    def format_date_time_schedule_option(self, date_time):
        # date_time: 'Wednesday, Oct. 19th, 2022 9:50 AM' => 'Wednesday, October 19 at 09:50 AM'
        date, time  = date_time.split('|')
        time = self.format_time(time)
        date = date.split(', ')
        day_of_week = date[0]
        day_of_month = re.findall(r'\d+', date[1].split('. ')[1])[0]
        month = self.format_to_month_in_full_string(date[1].split('. ')[0])
        return f'{day_of_week}, {month} {day_of_month} at {time}'


    def format_to_month_in_full_string(self, abb_month):
        month = 'January'
        match abb_month: 
            case 'Oct':
                month = 'October'
            case 'Nov':
                month = 'November'
            case 'Dec':
                month = 'December'
            case 'Jan':
                month = 'January'
            case 'Feb':
                month = 'February'
            case 'Mar':
                month = 'March'
            case 'Apr':
                month = 'April'
            case 'May':
                month = 'May'
            case 'Jun':
                month = 'June'
            case 'Jul':
                month = 'July'
            case 'Aug':
                month = 'August'
            case 'Sep':
                month = 'September'
        return month
        
    
    def format_time(self, time):
        # 1:20 -> 01:20
        hour = time.split(':')[0]
        time = f"0{hour}:{time.split(':')[1]}" if len(hour) == 1 else time
        return time
