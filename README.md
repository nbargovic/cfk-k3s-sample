# cfk-k3s-sample

This branch is a set of sample development scripts to install a FIPS compliant Confluent Platform on OpenShift.

0. Install CFK using helm bundle: [Instructions Here](https://docs.confluent.io/operator/current/co-deploy-cfk.html#deploy-co-using-the-download-bundle)
1. Generate BCFKS and JKS keystores/truststores
2. Create K8s secrets
3. Start the brokers with ```kubectl apply -f brokers.yaml```

Test functionality with commands in sample-client/test.txt
