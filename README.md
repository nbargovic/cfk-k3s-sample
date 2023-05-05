# cfk-k3s-sample
CP 7.3 and CFK 2.5 **aarch64** images available here: [https://hub.docker.com/u/bargovic](https://hub.docker.com/u/bargovic)

This is a set of sample development scripts to install Confluent Platform on Rancher K3s.

* Full TLS network encryption with user provided certificates - [docs here](https://docs.confluent.io/operator/current/co-network-encryption.html#user-provided-tls-certificates)
* Authentication via LDAP - [docs here](https://docs.confluent.io/operator/current/co-authenticate.html#sasl-plain-with-ldap-authentication)
* Authorization via RBAC - [docs here](https://docs.confluent.io/operator/current/co-rbac.html)
* RestProxy with RBAC Security - [docs here](https://docs.confluent.io/platform/current/kafka-rest/production-deployment/rest-proxy/security.html#role-based-access-control-rbac)
* Tiered Storage (AWS S3) enabled - [docs here](https://docs.confluent.io/operator/current/co-storage.html#tiered)
* Health+ Enabled - [docs here](https://docs.confluent.io/operator/current/co-monitor-cp.html#confluent-health)
* KSQL Migrations - [examples here](https://github.com/nbargovic/cfk-k3s-sample/tree/main/ksql-migrations)

Deployment Steps

1. Start LDAP with ```helm upgrade --install -f ./openldap/ldaps-rbac.yaml openldap ./openldap --namespace ldap```
2. If enabling Health+, create the api secret with ```kubectl create secret generic telemetry-auth --from-file=telemetry.txt=../credentials/telemetry.txt```
3. Install CFK using helm bundle: [Instructions Here](https://docs.confluent.io/operator/current/co-deploy-cfk.html#deploy-co-using-the-download-bundle)
4. Create the Certs and Secrets with the commands in ```./mtls/create-certs-and-secrets.txt```
5. Start the brokers with ```kubectl apply -f brokers.yaml -n confluent```
6. Add role bindings  ```kubectl apply -f rolebindings.yaml -n confluent```
7. Start the other services with ```kubectl apply -f services.yaml -n confluent```
8. Start RestProxy ```kubectl apply -f kafkarestproxy.yaml -n confluent```


