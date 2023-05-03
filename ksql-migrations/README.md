# Example use of ksql-migrations tool

### Add Necessary RoleBindings 
```
apiVersion: platform.confluent.io/v1beta1
kind: ConfluentRolebinding
metadata:
  name: ksql-migrations-rb-ksql
  namespace: confluent
spec:
  principal:
    type: user
    name: ksql
  role: ResourceOwner
  resourcePatterns:
    - name: confluent.ksqldb_ksql_MIGRATION
      patternType: PREFIXED
      resourceType: Topic
    - name: _confluent-ksql-confluent.ksqldb_
      patternType: PREFIXED
      resourceType: Topic
    - name: order
      patternType: PREFIXED
      resourceType: Topic
 ```

### Initialize a migrations project
Note: when editing ksql-migrations.properties be sure to set `ksql.migrations.topic.replicas=3`
```
1. ksql-migrations new-project project1 https://ksqldb.fios-router.home:443

2. vi project1/ksql-migrations.properties

3. ksql-migrations initialize-metadata -c project1/ksql-migrations.properties
```

### Create a migration
```
1. ksql-migrations create project1_baseline -c project1/ksql-migrations.properties

2. vi project1/migrations/V000001__project1_baseline.sql
```

### Validate the migration
```
1. ksql-migrations -c project1/ksql-migrations.properties info

2. ksql-migrations -c project1/ksql-migrations.properties validate

2. ksql-migrations apply -n -c project1/ksql-migrations.properties --dry-run
```

### Run the migration
```
ksql-migrations apply -n -c project1/ksql-migrations.properties
```

### Links
- https://docs.ksqldb.io/en/latest/operate-and-deploy/migrations-tool/
- https://docs.ksqldb.io/en/latest/operate-and-deploy/migrations-tool/#setup-and-initialization
- https://docs.ksqldb.io/en/0.23.1-ksqldb/operate-and-deploy/migrations-tool/#validation-failures