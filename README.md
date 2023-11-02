# RobotAutomationTest

This is an automation testing project using Robot Framework.

## Installation
> **⚠ WARNING:**  
> Do not follow this guide step-by-step. Read each command's sort description carefully, and run the command only if you are facing problems.
---
### 1.1. Install Python 3.10.

```bash
sudo apt-get install python3.10
```
### 1.2. Install deadsnakes PPA
- By default Ubuntu system only have just the Python 2.x and Python 3.x that comes with distribution. So if you have problem to install Python 3.10, just following next step
-  Install deadsnakes PPA lets you install multiple Python versions on your Ubuntu system
```
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get install python3.10
```
---
### 2. Install Python 3.10 virtual environment

```bash
sudo apt-get install python3.10-dev python3.10-venv
```
---
### 3. If your system has a different Python version before. Follow the instructions below to change the Python version
- Add Python version to update-alternatives (`x` represents the pre-existing Python version)

```bash
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.x 1
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 2
```
- Update Python 3 to point to Python 3.10

```bash
sudo update-alternatives --config python3
```
- Select the number containing Python 3.10 and hit Enter (in this case is number 1)
```bash
  Selection    Path                 Priority   Status
------------------------------------------------------------
  0            /usr/bin/python3.10   3         auto mode
* 1            /usr/bin/python3.10   3         manual mode
  2            /usr/bin/python3.6    1         manual mode
  3            /usr/bin/python3.7    2         manual mode
```
##  Clone the project and setup environment
- Clone project with SSH

```bash
git clone git@github.com:ParadoxAi/RobotAutomationTest.git
```
- Create virtual environment in install requirement (delete `venv` folder if it already exists before installing Python 3.10)
```bash
cd RobotAutomationTest
sudo chmod +x run.sh
./run.sh
```
##  Usage
---
### 1. Generate test cases from Excel
- Change the `filePath` in `src/utils/GenerateRobotFile.py` to your Excel file
```python
# Change `filePath` below
filePath = '../../resources/tests_excel/your_excel_file.xlsx'
GenerateRobotFile().genRobotFile(filePath)
```
- Run `src/utils/GenerateRobotFile.py`
```bash
python3 src/utils/GenerateRobotFile.py
```
---
### 2.1 Run test cases and check the reports
#### Export PYTHONPATH every time you open project
```bash
. venv/bin/activate
export PYTHONPATH=path/to/your/project
```
#### Run single test case
```bash
robot -t "Test Case Name" /path/to/robot/file/test_file.robot
```
- The returned results will have a path to the `report.html` file used to check the results
```bash
Robot Files                                                                   
==============================================================================
Test File :: Test Case Name.                        
==============================================================================
Test Case Name                                                        | PASS |
------------------------------------------------------------------------------
Test File :: Test Case Name.                                          | PASS |
1 tests, 1 passed, 0 failed
==============================================================================
Test File                                                             | PASS |
1 tests, 1 passed, 0 failed
==============================================================================
Output:  /output.xml
Log:     /log.html
Report:  /report.html
```
#### Run a parallel executor for the test suite
```bash
pabot --pabotlib --pabotlibport 3978 --testlevelsplit --processes 10 -d results -o output.xml --variable env:STG /path/to/robot/file/test_file.robot
```
- Optional parameters:
```
-i, --include <tag>
 	Include tests by tags.

-e, --exclude <tag>
 	Exclude tests by tags.

--tagstatinclude <tag>
 	Includes only these tags in the Statistics by Tag table in Report file.
```
- The returned results will have a path to the `report.html` file used to check the results
```bash
[PID:9] [0] EXECUTING Suites.Suite2.Test 4
[PID:7] [1] EXECUTING Suites.Suite2.Test 3
[PID:8] [2] EXECUTING Suites.Suite1.Test 1
[PID:2] [3] EXECUTING Suites.Suite1.Test 2
[PID:9] [0] PASSED Suites.Suite2.Test 4
[PID:2] [3] PASSED Suites.Suite1.Test 2
[PID:7] [1] PASSED Suites.Suite2.Test 3
[PID:8] [2] PASSED Suites.Suite1.Test 1
Output:  /output.xml
Log:     /log.html
Report:  /report.html
Total testing: 18.80 seconds
Elapsed time:  7.27 seconds
```
### 2.2. Plugins for Pycharm
Following this [Document](https://www.jetbrains.com/help/pycharm/managing-plugins.html) to install 3 plugins below in Pycharm
- Robot Framework support
- Run Robot Framework TestCase
- Robot Runner
---
### 3. Config Robotidy rules and format code
- Document: https://robotidy.readthedocs.io/en/latest/configuration/index.html
- The rules was defined in `robotidy_config.toml`
- Run the command 
```bash
robotidy --config robotidy_config.toml path/to/robot/file
```

### Debug
- in case you get error with ModuleNotFoundError: No module named 'src'
export PYTHONPATH="path_to_your_project"
- Add this command into TC which you want debug
Import library   DebugLibrary
Debug
- Run this command in terminal to start debug.
ROBOT_SELENIUM_RUN_ON_FAILURE=Debug robot -t "TC name" path_to_robot_file_which_contains_this_TC
- input next or enter to go to next step of TC
- input ${variable} and enter to show value of this variable.