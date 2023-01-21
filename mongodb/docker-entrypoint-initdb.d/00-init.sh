#!/bin/bash

mongoimport --db='eld' --collection='mt' --file='/docker-entrypoint-initdb.d/mt.jsonl'