# cfk-k3s-sample

This is a set of sample development scripts to install Confluent Platform on Rancher K3s.

CP 7.3.1 and CFK 2.5.1 Containers available here: [https://hub.docker.com/u/bargovic](https://hub.docker.com/u/bargovic)

1. Start LDAP with ```helm upgrade --install -f ./openldap/ldaps-rbac.yaml openldap ./openldap --namespace ldap```
2. If enabling Health+, create the api secret with ```kubectl create secret generic telemetry-auth --from-file=telemetry.txt=../credentials/telemetry.txt```
3. Install CFK using helm bundle: [Instructions Here](https://docs.confluent.io/operator/current/co-deploy-cfk.html#deploy-co-using-the-download-bundle)
4. Create the Certs and Secrets with the commands in ```./mtls/create-certs-and-secrets.txt```
5. Start the brokers with ```kubectl apply -f brokers.yaml -n confluent```
6. Start the other services with ```kubectl apply -f services.yaml -n confluent```
7. Add role bindings  ```kubectl apply -f rolebindings.yaml -n confluent```

