#!/bin/bash

db2 -td@ -vf create_index2.sql | tee create_index2.log