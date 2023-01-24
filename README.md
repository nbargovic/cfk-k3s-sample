# cfk-k3s-sample

This is a set of sample development scripts to install Confluent Platform on Rancher K3s.

CP 7.3.1 and CFK 2.5.1 are Containers available here: [https://hub.docker.com/u/bargovic](https://hub.docker.com/u/bargovic)

0. Install CFK using helm bundle: [Instructions Here](https://docs.confluent.io/operator/current/co-deploy-cfk.html#deploy-co-using-the-download-bundle)
1. Start the brokers with ```kubectl apply -f brokers.yaml```
2. Start the other services with ```kubectl apply -f services.yaml```

TODO:
- setup RBAC and security.
