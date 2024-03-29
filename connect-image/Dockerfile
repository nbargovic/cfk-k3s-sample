FROM confluentinc/cp-server-connect:7.6.0-2-ubi8.arm64

USER root

RUN confluent-hub install --no-prompt confluentinc/kafka-connect-sftp:3.2.3 \
    && confluent-hub install --no-prompt confluentinc/kafka-connect-s3:10.5.9 \
    && confluent-hub install --no-prompt confluentinc/kafka-connect-s3-source:2.5.15 \
    && confluent-hub install --no-prompt confluentinc/kafka-connect-snmp:1.3.0 \
    && confluent-hub install --no-prompt confluentinc/kafka-connect-syslog:1.5.7

ADD plugins/kafka-connect-custom-transforms-2.0.0.jar /usr/share/confluent-hub-components/confluentinc-kafka-connect-syslog/lib/kafka-connect-custom-transforms-2.0.0.jar

USER 1001