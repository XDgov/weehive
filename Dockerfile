# https://www.digitalocean.com/community/tutorials/how-to-install-hadoop-in-stand-alone-mode-on-ubuntu-18-04

FROM ubuntu:bionic

WORKDIR /usr/local/hadoop

# default-jdk
RUN apt-get update && apt-get install -y openjdk-8-jdk
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/

ARG HADOOP_VERSION=3.2.0
# ADD http://apache.osuosl.org/hadoop/common/stable/hadoop-$HADOOP_VERSION.tar.gz hadoop-$HADOOP_VERSION.tar.gz
# RUN tar -xzf hadoop-$HADOOP_VERSION.tar.gz
ADD hadoop-$HADOOP_VERSION.tar.gz .
ENV HADOOP_HOME /usr/local/hadoop/hadoop-$HADOOP_VERSION

ARG HIVE_VERSION=3.1.1
# ADD http://mirrors.advancedhosters.com/apache/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz apache-hive-$HIVE_VERSION-bin.tar.gz
# RUN tar -xzf apache-hive-$HIVE_VERSION-bin.tar.gz
ADD apache-hive-$HIVE_VERSION-bin.tar.gz .
ENV HIVE_HOME /usr/local/hadoop/apache-hive-$HIVE_VERSION-bin
# https://stackoverflow.com/a/41789082/358804
RUN rm $HIVE_HOME/lib/log4j-slf4j-impl-2.10.0.jar

# https://cwiki.apache.org/confluence/display/Hive/GettingStarted#GettingStarted-RunningHive
RUN $HADOOP_HOME/bin/hadoop fs -mkdir -p /tmp
RUN $HADOOP_HOME/bin/hadoop fs -mkdir -p /user/hive/warehouse
RUN $HADOOP_HOME/bin/hadoop fs -chmod g+w /tmp
RUN $HADOOP_HOME/bin/hadoop fs -chmod g+w /user/hive/warehouse

RUN $HIVE_HOME/bin/schematool -dbType derby -initSchema

# CMD $HIVE_HOME/bin/hive
# https://cwiki.apache.org/confluence/display/Hive/GettingStarted#GettingStarted-RunningHiveServer2andBeeline.1
CMD $HIVE_HOME/bin/beeline -u jdbc:hive2://
