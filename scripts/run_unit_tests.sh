#!/bin/bash
docker exec ci-project-container /bin/bash -c "cd /etc/app_code; ./gradlew clean test"
docker cp ci-project-container:/etc/app_code/app/build/test-results $(pwd)