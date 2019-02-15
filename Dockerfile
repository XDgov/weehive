# https://www.digitalocean.com/community/tutorials/how-to-install-hadoop-in-stand-alone-mode-on-ubuntu-18-04

FROM ubuntu:bionic

WORKDIR /usr/local/hadoop

RUN apt-get update && apt-get install -y openjdk-8-jdk
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/

ARG HADOOP_VERSION=3.2.0
# COPY http://apache.osuosl.org/hadoop/common/stable/hadoop-$HADOOP_VERSION.tar.gz .
# RUN tar -xzf hadoop-$HADOOP_VERSION.tar.gz
ADD hadoop-$HADOOP_VERSION.tar.gz .
ENV HADOOP_HOME /usr/local/hadoop/hadoop-$HADOOP_VERSION
ENV PATH="${HADOOP_HOME}/bin:${PATH}"

ARG HIVE_VERSION=3.1.1
# COPY http://mirrors.advancedhosters.com/apache/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz .
# RUN tar -xzf apache-hive-$HIVE_VERSION-bin.tar.gz
ADD apache-hive-$HIVE_VERSION-bin.tar.gz .
ENV HIVE_HOME /usr/local/hadoop/apache-hive-$HIVE_VERSION-bin
ENV PATH="${HIVE_HOME}/bin:${PATH}"
# https://stackoverflow.com/a/41789082/358804
RUN rm $HIVE_HOME/lib/log4j-slf4j-impl-2.10.0.jar

# https://cwiki.apache.org/confluence/display/Hive/GettingStarted#GettingStarted-RunningHive
RUN hadoop fs -mkdir -p /tmp
RUN hadoop fs -mkdir -p /user/hive/warehouse
RUN hadoop fs -chmod g+w /tmp
RUN hadoop fs -chmod g+w /user/hive/warehouse

# https://cwiki.apache.org/confluence/display/Hive/GettingStarted#GettingStarted-RunningHiveServer2andBeeline.1
RUN schematool -dbType derby -initSchema
CMD beeline -u jdbc:hive2://
