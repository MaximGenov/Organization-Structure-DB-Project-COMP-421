#!/bin/bash
db2 connect to COMP421
db2 -t -v -f advanced_feature_query.sql 2>&1 | tee advanced_feature_query.log
