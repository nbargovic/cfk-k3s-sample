# cfk-eks-sample

This is a set of sample development scripts to install Confluent Platform on AWS EKS.

* Full TLS network encryption with user provided certificates - [docs here](https://docs.confluent.io/operator/current/co-network-encryption.html#user-provided-tls-certificates)
* Authentication via LDAP - [docs here](https://docs.confluent.io/operator/current/co-authenticate.html#sasl-plain-with-ldap-authentication)
* Authorization via RBAC - [docs here](https://docs.confluent.io/operator/current/co-rbac.html)
* Tiered Storage (AWS S3) enabled - [docs here](https://docs.confluent.io/operator/current/co-storage.html#tiered)

Prerequisites

* Enable the EBS dynamic provisioner on the EKS cluster [docs here](https://docs.aws.amazon.com/eks/latest/userguide/ebs-csi.html)
* Setup the AWS Load Balancer Controller [docs here](https://docs.aws.amazon.com/eks/latest/userguide/lbc-helm.html)
* Create a default storage class using ```kubectl apply of storageclass.yaml```
* Ensure Subnets are tagged correctly for AWS ELBs to work.

Deployment Steps

1. Start LDAP with ```helm upgrade --install -f ./openldap/ldaps-rbac.yaml openldap ./openldap --namespace ldap```
2. Install CFK using helm bundle: [Instructions Here](https://docs.confluent.io/operator/current/co-deploy-cfk.html#deploy-co-using-the-download-bundle)
3. Create the Certs and Secrets with the commands in ```./mtls/create-certs-and-secrets.txt```
4. Start the brokers with ```kubectl apply -f brokers.yaml -n confluent```
5. Add role bindings  ```kubectl apply -f rolebindings.yaml -n confluent```
6. Start the other services with ```kubectl apply -f services.yaml -n confluent```
7. Start ControlCenter with ```kubectl apply -f controlcenter.yaml -n confluent```
8. Update /etc/hosts with ELB IPs. Or setup Route 53 DNS



