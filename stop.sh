#!/bin/bash

docker stop rp1 rp2 rp3
docker rm rp1 rp2 rp3
docker network rm network1
docker network rm network2
docker network rm network3

