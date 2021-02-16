FROM ubuntu:18.04

# Set Java environment variables
ENV JAVA_URL=https://download.oracle.com/otn-pub/java/jdk/15.0.2%2B7/0d1cfde4252546c6931946de8db48ee2/jdk-15.0.2_linux-x64_bin.tar.gz
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH=$PATH:$JAVA_HOME/bin

# Install curl and unzip onto Ubuntu
RUN apt-get update \
    && apt-get install curl -y \ 
    && apt-get install unzip -y

# Install Java
RUN curl -jkL -H "Cookie: oraclelicense=accept-securebackup-cookie" ${JAVA_URL} -o jdk.tar.gz \
    && tar -xzvf jdk.tar.gz \
	&& rm jdk.tar.gz \
	&& mkdir -p /opt/java \
	&& mv jdk-* ${JAVA_HOME}

# Set environment variables for Android SDK install
ENV CMD_LINE_TOOLS https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip
ENV ANDROID_HOME=/usr/local/android-sdk
ENV PATH=$PATH:$ANDROID_HOME/platform-tools

# Install Android SDK
RUN mkdir -p $ANDROID_HOME 
RUN cd $ANDROID_HOME \
	&& curl ${CMD_LINE_TOOLS} -o cmd_line_tools.zip \
  	&& unzip cmd_line_tools.zip \
	&& rm cmd_line_tools.zip
RUN $ANDROID_HOME/cmdline-tools/bin/sdkmanager --sdk_root=${ANDROID_HOME} --update 
RUN yes | $ANDROID_HOME/cmdline-tools/bin/sdkmanager --sdk_root=${ANDROID_HOME} --licenses
