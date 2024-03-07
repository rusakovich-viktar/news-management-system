#!/bin/bash

cd micro-exception-starter
gradle build publish

cd ../logger-aspect-starter
gradle build publish

cd ../micro-config-server
gradle build -x test

cd ../micro-news
gradle build -x test

cd ../micro-comments
gradle build -x test

cd ../micro-search
gradle build -x test

cd ../micro-gateway
gradle build -x test

cd ..
docker-compose up --build