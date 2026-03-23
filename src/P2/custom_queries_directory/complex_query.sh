#!/bin/bash
db2 connect to COMP421
db2 -t -v -f complex_query.sql 2>&1 | tee complex_query.log
