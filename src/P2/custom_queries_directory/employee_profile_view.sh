#!/bin/bash
db2 connect to COMP421
db2 -t -v -f employee_profile_view.sql 2>&1 | tee employee_profile_view.log
