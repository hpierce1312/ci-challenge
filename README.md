# The QA automation challenge

You're given a very basic Android app. You will need to implement a complete CI pipeline with automated UI tests for this app
using Jenkins and Docker according to the specification below.

You will need a Linux or Mac host OS. You will need to install Docker and Jenkins on your local dev
machine before you begin the challenge. You may also install any extra Jenkins plugins that you might need.

The app has a very basic UI: a button and a label with the value 0. When the user taps the button, the value in the label is
incremented - 1, 2, 3, etc. The app project also has a unit test suite in it.


## Task 1 - Automated UI tests

Develop an automated UI test project that will assert the app's functionality as specified above. The test project
should have a single test that uses UI automation to tap the button a couple of times, read out the value of the
label and assert the expected text after each tap. You may use any automation framework (Appium, Selendroid, etc.)


## Task 2 - Jenkins jobs

Read Task 3 before starting work on Task 2. You will probably want to do both tasks in parallel.

Develop the following jobs using Jenkins Job Builder that build and test the app:
* Build - a job that checks out the source code of the app and runs the gradle build to produce the app's final .apk
* Run unit tests - a job that checks out the source code of the app and runs the gradle unit tests. The job
  must assimilate the test results and present them in the build status, maybe using the JUnit Jenkins plugin or
  something similar. The build should be marked as unstable if the unit tests fail.
* Run automation tests - a job that takes a selected .apk build artifact from the Build job and runs the automation
  tests in an Android emulator. The test results should be presented in the build's status, again, using a suitable
  Jenkins plugin. The build should be marked as unstable if any of the tests fail.


## Task 3 (bonus points) - Isolation using Docker

Ideally, Jenkins jobs should be self-sufficient. No extra software should be installed on the Jenkins agent to make
the jobs run. Docker is the perfect tool to bring self-sufficiency to the build process.

All build jobs require the Android SDK - both for the build itself and for running the Android emulator. We'd like
the build job to run in a container, so that we don't need to install the SDK's build tools on the Jenkins agent.
It's not possible to run the emulator in a container though. We will need to run the emulator on the host, but
we still want the gradle script to run in a container - and communicate with the emulator on the host *from* the container.

Create a Dockerfile from which a Docker image can be built that contains all of the bits of the
Android SDK that are necessary to build the app.

Modify the Build job from Task 2 as follows. After cloning the project repo, create a Docker image from the Dockerfile.
Docker caches the image, so this step should take a lot of time only on the first run or when the Dockerfile changes.
Run the gradle build in a container started from this image. Mount the app's source code as a volume (-v option of
`docker run`), don't copy the source into the container.

Modify the Run unit tests job from Task 2 as follows. Make the same changes as in the Build job to be able to build
the unit test project in a container. In addition to that, forward the Android emulator's port 5554 on the host machine
to the container. This way `adb` from inside the container can talk to the emulator running on the host.

For extra bonus points, you can automate the start-up and shutdown of the emulator on the host. Otherwise you
may just assume in the build script that a single emulator is always running on the host.


Your deliverables are:
* The automation project that implements the automated UI tests as described above
* The jenkins-job-builder script that creates the jobs listed above
* Console logs from the Build, Run unit tests and Run automation tests jobs. The console logs will demonstrate the correct
  functioning of the jobs. Include logs from both stable and unstable builds. Include screenshots of the respective builds'
  Status page in Jenkins.
* Dockerfile of the Docker image that is used to build the app and run its unit tests.


## Do's and don'ts:

* Do install any extra Jenkins plugins that you need
* Don't use sudo or root privileges in any of the build scripts.

### For Task 3:

* Do copy/paste from any freely available Dockerfiles to create the build environment if necessary.
* Do use official Ubuntu images from Dockerhub. Don't use any other third-party images.
* Don't leave stopped containers, dangling images or other junk in Docker. All Docker commands should
  clean up after themselves
* Don't install any of the Android SDK build tools on the host machine running the Jenkins Agent. The only allowed
  parts of the Android SDK on the Jenkins Agent are the ones necessary to get the emulator to work.
