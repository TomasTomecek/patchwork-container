#!/bin/bash
set -x
python3 ./manage.py migrate
python3 ./manage.py loaddata default_tags
python3 ./manage.py loaddata default_states
python3 ./manage.py loaddata default_projects
test -n "${INITIAL_FIXTURE}" && python3 ./manage.py loaddata $INITIAL_FIXTURE
