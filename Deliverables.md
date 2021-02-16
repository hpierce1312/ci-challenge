# Project Deliverables

## 1. The automation project that implements the automated UI tests
Source code for this Appium test suite is located at: https://github.com/hpierce1312/appium_test_suite

## 2. The Jenkins Job Builder script that creates the Jenkins jobs
There are 3 separate jobs which are driven by the following YAML files and Bash scripts:

### 1. Build Job: 
* [build_job.yaml](https://github.com/eddyfrank/ci-challenge_hudson-pierce/blob/main/jobs/build_job.yaml)
* [build.sh](https://github.com/eddyfrank/ci-challenge_hudson-pierce/blob/main/scripts/build.sh)

### 2. Run Unit Tests Job: 
* [run_unit_tests.yaml](https://github.com/eddyfrank/ci-challenge_hudson-pierce/blob/main/jobs/run_unit_tests.yaml)
* [run_unit_tests.sh](https://github.com/eddyfrank/ci-challenge_hudson-pierce/blob/main/scripts/run_unit_tests.sh)

### 3. Run Automation Tests Job: 
* [run_automation_tests.yaml](https://github.com/eddyfrank/ci-challenge_hudson-pierce/blob/main/jobs/run_automation_tests.yaml)
* [run_automation_tests.sh](https://github.com/eddyfrank/ci-challenge_hudson-pierce/blob/main/scripts/run_automation_tests.sh)

In order to create the Jenkins jobs based on the YAML configuration files, run `jenkins-jobs update --conf jenkins_jobs.ini jobs` where jenkins_jobs.ini is like the file shown [here](https://github.com/eddyfrank/ci-challenge_hudson-pierce/blob/main/jenkins_jobs.ini). 

Furthermore, `jobs` refers to the [jobs folder](https://github.com/eddyfrank/ci-challenge_hudson-pierce/tree/main/jobs) with all the Jenkins Job Builder YAML files.


## 3. Console logs and Screenshots from the Build, Run Unit Tests, and Run Automation Tests jobs.
### Stable Builds:
* [Build Job Logs](https://github.com/eddyfrank/ci-challenge_hudson-pierce/blob/main/logs/stable/build_job_logs_stable.txt)
* [Run Unit Tests Logs](https://github.com/eddyfrank/ci-challenge_hudson-pierce/blob/main/logs/stable/run_unit_tests_logs_stable.txt)
* [Run Automation Tests Logs](https://github.com/eddyfrank/ci-challenge_hudson-pierce/blob/main/logs/stable/run_automation_tests_logs_stable.txt)
  
### Unstable Builds:
* [Run Unit Tests Logs](https://github.com/eddyfrank/ci-challenge_hudson-pierce/blob/main/logs/unstable/run_unit_tests_logs_unstable.txt)
* [Run Automation Tests](https://github.com/eddyfrank/ci-challenge_hudson-pierce/blob/main/logs/unstable/run_automation_tests_logs_unstable.txt)

### Screenshots:

![alt text](https://github.com/eddyfrank/ci-challenge_hudson-pierce/blob/main/screenshots/run_unit_tests_screenshot.png)

![alt_text](https://github.com/eddyfrank/ci-challenge_hudson-pierce/blob/main/screenshots/run_automation_test_screenshot.png)

## 4. Dockerfile of the Docker image that is used to build the app and run its unit tests.

This Dockerfile can be viewed [here](https://github.com/eddyfrank/ci-challenge_hudson-pierce/blob/main/Dockerfile)


# Additional setup instructions based on my environment (Mac)

### 1. Installed the Jenkins plugins which were suggested by default during installation. 
I did not use additional plugins besides these.

### 2. Set PATH environment variable in Jenkins 
Since Docker was installed at `/usr/local/bin` instead of `/usr/bin` Jenkins was not able to run the `docker` command.

If you encounter this error, go to Jenkins > Manage Jenkins > Configure System > Global Properties > check Environment Variables > enter `PATH` as `/usr/local/bin:/bin`
