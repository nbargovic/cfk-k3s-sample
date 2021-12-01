FROM confluentinc/cp-kafka-rest:6.1.3
USER root
RUN mkdir /mnt/sslcerts
COPY ./keystore.p12 /mnt/sslcerts/keystore.p12
COPY ./truststore.p12 /mnt/sslcerts/truststore.p12
COPY ./jksPassword.txt /mnt/sslcerts/jksPassword.txt
USER 1001