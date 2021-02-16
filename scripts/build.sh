#!/bin/bash

# build a Docker image based off Dockerfile
docker build -t ci-project:v1 .

# clone Demo App source code
mkdir -p ci-android-demo-app_hudson-pierce
git clone https://github.com/eddyfrank/ci-android-demo-app_hudson-pierce.git ci-android-demo-app_hudson-pierce

# get app source code into Docker container while keeping container running (so we can run exec command and docker commit)
docker run -p 5554:5554 -p 4723:4723 -d --name ci-project-container -v $(pwd)/ci-android-demo-app_hudson-pierce:/etc/app_code ci-project:v1 tail -f /dev/null 

# run Gradle build and commit to Docker image
docker exec ci-project-container /bin/bash -c "cd /etc/app_code; ./gradlew assembleDebug"
docker commit ci-project-container ci-project:v1