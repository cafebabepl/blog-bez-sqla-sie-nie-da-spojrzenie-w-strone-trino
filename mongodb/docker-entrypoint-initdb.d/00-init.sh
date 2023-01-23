#!/bin/bash

mongoimport --db='eld' --collection='clients' --file='/docker-entrypoint-initdb.d/mt.jsonl'