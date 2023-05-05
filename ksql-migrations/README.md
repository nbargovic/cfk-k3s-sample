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

### Rollback/Replay a migration
You can edit the last migration and re-run it with corrections, by using the following steps. 

Note that you might need to manually modify or drop streams if your last migration put your streams pipeline in a state that cannot be evolved.  If that is the case, use the ksql shell or control center ksql editor to revert your stream pipeline first.

1. Log into the ksql shell and inspect the migration events stream and schema table:
```
ksql -u ksql https://ksqldb.fios-router.home --configfile ./mtls/ksql.properties
select * from MIGRATION_EVENTS_PROJECT1;
select * from MIGRATION_SCHEMA_VERSIONS_PROJECT1;
```
2. Identify the messages with latest version_key number (2 in this example), and the version_key set to CURRENT.

3. Insert a message into the MIGRATION_EVENTS stream to set the last and current migration to ERROR state.
```
INSERT INTO MIGRATION_EVENTS_PROJECT1 (
    version_key, 
    version, 
    name, 
    state, 
    checksum, 
    started_on, 
    completed_on, 
    previous, 
    error_reason
) VALUES (
    '2',
    '2',
    'project1 update order events',
    'ERROR',
    '72da014f03d7bc168fc5e0f48e6d8549',
    '1683214502471',
    '1683214505823',
    '1',
    'Manual abort after migration mistake'
);

INSERT INTO MIGRATION_EVENTS_PROJECT1 (
    version_key, 
    version, 
    name, 
    state, 
    checksum, 
    started_on, 
    completed_on, 
    previous, 
    error_reason
) VALUES (
    'CURRENT',
    '2',
    'project1 update order events',
    'ERROR',
    '72da014f03d7bc168fc5e0f48e6d8549',
    '1683214502471',
    '1683214505823',
    '1',
    'Manual abort after migration mistake'
);
```
4. Verify the current state is set to ERROR:
```
ksql-migrations -c project1/ksql-migrations.properties info
```
5. Modify the migration sql file, and re-run it:
```
ksql-migrations apply -n -c project1/ksql-migrations.properties
```

### Links
- https://docs.ksqldb.io/en/latest/operate-and-deploy/migrations-tool/
- https://docs.ksqldb.io/en/latest/operate-and-deploy/migrations-tool/#setup-and-initialization
- https://docs.ksqldb.io/en/0.23.1-ksqldb/operate-and-deploy/migrations-tool/#validation-failures