# cleans up folders and Docker if build fails or after all jobs have run
docker rm ci-project-container -f
docker system prune -f
docker image prune -a -f
rm -rf ci-android-demo-app_hudson-pierce