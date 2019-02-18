# WeeHive

A minimal-as-possible Docker container running [Apache Hive](https://hive.apache.org/) on [Hadoop](https://hadoop.apache.org/). Intended for non-production use cases like testing out Hive code or running integration tests.

## Usage

To use beeline directly:

```sh
docker run --rm -it \
  -v weehive_hadoop:/user/hive/warehouse \
  -v weehive_meta:/usr/local/hadoop/metastore_db \
  weehive
```

To connect remotely:

1. Run the server.

   ```sh
   docker run --rm -it -p 10000:10000 \
     -v weehive_hadoop:/user/hive/warehouse \
     -v weehive_meta:/usr/local/hadoop/metastore_db \
     weehive hiveserver2
   ```

1. Connect using the [JDBC URL](https://cwiki.apache.org/confluence/display/Hive/HiveServer2+Clients#HiveServer2Clients-JDBC) `jdbc:hive2://localhost:10000`. Example from an external `beeline`:

   ```sh
   beeline -u jdbc:hive2://localhost:10000
   ```

## Development

```sh
docker build -t weehive:local .

docker run --rm -it -p 10000:10000 weehive:local \
  beeline -u jdbc:hive2:// -e 'show tables;'
```
