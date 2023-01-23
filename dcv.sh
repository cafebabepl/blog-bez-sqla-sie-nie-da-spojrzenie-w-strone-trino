#!/bin/bash
docker run --rm -it --name dcv -v $(pwd):/input pmsipilot/docker-compose-viz render -m image -f --horizontal docker-compose.yml