#!/bin/bash

# export necessary environment variables
export ANDROID_SDK=$HOME/Library/Android/sdk
export PATH=$ANDROID_SDK/emulator:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools:$PATH

# start emulator in the background on host 
device=Nexus_6_API_30
emulator -avd $device &

# apk path from apk generated in build job
apk_path=/etc/app_code/app/build/outputs/apk/debug/app-debug.apk

# use adb inside the container to start
docker exec ci-project-container /bin/bash -c "timeout 30 adb wait-for-device; \
    adb connect host.docker.internal ; \
    adb install $apk_path"

# clone Appium test suite on host and copy it to the running container
mkdir -p appium_test_suite
git clone https://github.com/hpierce1312/appium_test_suite.git appium_test_suite
docker cp appium_test_suite ci-project-container:/etc/appium_test_suite
rm -rf appium_test_suite

# install Appium in Docker container and run Appium Server from there on 4723
docker exec ci-project-container /bin/bash -c "curl -sL https://deb.nodesource.com/setup_14.x | bash; \
    apt-get install nodejs -y; \
    npm install -g appium --chromedriver-skip-install; \
    nohup appium >/dev/null &"

# setup Python and Appium and run tests
docker exec ci-project-container /bin/bash -c "apt-get install -y python3; \
    apt-get install python3-pip -y; \
    cd /etc/appium_test_suite; \
    pip3 install -r requirements.txt; \
    python3 appium_test_suite.py"

# copy test xml test results to present working directory
docker cp ci-project-container:/etc/appium_test_suite/appium_test_results.xml $(pwd)

# kill emulator
adb emu kill