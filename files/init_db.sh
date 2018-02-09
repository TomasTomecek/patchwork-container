#!/bin/bash
python3 ./manage.py migrate
python3 ./manage.py loaddata default_tags
python3 ./manage.py loaddata default_states
python3 ./manage.py loaddata default_projects
