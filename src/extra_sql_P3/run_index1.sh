#!/bin/bash

db2 -td@ -vf create_index1.sql | tee create_index1.log