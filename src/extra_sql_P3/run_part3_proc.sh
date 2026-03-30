#!/bin/bash

db2 -td@ -vf create_hold_old_tasks_proc.sql | tee create_hold_old_tasks_proc.log
db2 -td@ -vf test_hold_old_tasks_proc.sql | tee test_hold_old_tasks_proc.log