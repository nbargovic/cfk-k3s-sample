FROM confluentinc/cp-server-connect-operator:6.1.3.0
USER root
RUN confluent-hub install --no-prompt confluentinc/kafka-connect-http:1.5.0
USER 1001