#FROM confluentinc/cp-kafka-connect-base

#FROM openjdk:8u102-jre

#ENV kafka_version=0.10.1.1
#ENV scala_version=2.11.8
#ENV kafka_bin_version=2.11-$kafka_version

#RUN curl -SLs "http://www.scala-lang.org/files/archive/scala-$scala_version.deb" -o scala.deb \
#	&& dpkg -i scala.deb \
#	&& rm scala.deb \
#	&& curl -SLs "http://www.apache.org/dist/kafka/$kafka_version/kafka_$kafka_bin_version.tgz" | tar -xzf - -C /opt \
#	&& mv /opt/kafka_$kafka_bin_version /opt/kafka

#WORKDIR /opt/kafka
# above should be removed once kafka is delivered to armdocker by AIA platform

#connect starts from below
FROM armdocker.rnd.ericsson.se/aia/base/kafka:0.10.2.1
MAINTAINER PDLYMERAIA@pdl.internal.ericsson.com

ENV COMPONENT=kafka-connect

ARG KAFKA_HOME=/opt/kafka/

ADD connect-${project.version}.tar.gz /var/tmp/kafka/

RUN echo "===> Installing JDBC, File and Hadoop connectors ..." \
    && mv /var/tmp/kafka/lib/*.jar $KAFKA_HOME/libs/ \
    && mv /var/tmp/kafka/bin/start-connect.sh $KAFKA_HOME/bin/ 

RUN echo "===> Cleaning up ..."  \
    && rm -rf /var/tmp/kafka/lib


ENTRYPOINT ["/opt/kafka/bin/start-connect.sh"]
#ENTRYPOINT ["/bin/bash"]
CMD ["/var/tmp/kafka/etc/connect-standalone.properties", "/var/tmp/kafka/etc/connect-file-source.properties", "/var/tmp/kafka/etc/connect-file-source.properties"]

