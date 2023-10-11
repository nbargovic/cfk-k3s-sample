# Schemas
CFK provides the Schema custom resource definition (CRD). With the Schema CRD, you can declaratively create, read, and delete schemas as Schema custom resources (CRs) in Kubernetes.

## To create a schema for a topic using CFK
0. Create a topic named `topic-schema-cfk`
1. Add Necessary RoleBindings
```
kubectl apply -f sr-rolebindings.yaml
```
2. Deploy the ConfigMap resource containing the schema:
```
kubectl apply -f schema-config.yaml
```
3. Deploy the Schema CR:
```
kubectl apply -f schema.yaml 
```
4. Check that schema config and schema CR are deployed:
```
kubectl get configmap -n confluent 
kubectl get schema -n confluent
```

## Validation
You should now see the schema on your topic in Control Center under the Topic -> Schema tab.

NOTE: It seems required to name your schema as `<topic-name>-value`, or `<topic-name>-key` in order for the schema to be applied directly to the topic.  In this example we use `topic-schema-cfk-value`.