# make virtual env and install lib to framework
python3 -m venv venv
. venv/bin/activate
pip3 install -r requirements.txt
# for debug
pip install robotframework-debuglibrary
pip install helper

