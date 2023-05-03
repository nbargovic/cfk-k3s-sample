TERMINATE ALL;

CREATE OR REPLACE STREAM ORDER_EVENTS (
  orderid STRING,
  name STRING,
  items ARRAY<STRING>,
  cost DECIMAL(6, 2),
  ordertime TIMESTAMP
) WITH (
  kafka_topic='order_event',
  partitions=1,
  value_format='json'
);

CREATE OR REPLACE STREAM ORDER_NAMES_PERSISTENT
WITH(
  KAFKA_TOPIC = 'order-names-persistent',
  PARTITIONS = 1
)
AS SELECT
  orderid,
  name
FROM ORDER_EVENTS;