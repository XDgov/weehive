# WeeHive

A minimal-as-possible Docker container running [Apache Hive](https://hive.apache.org/) on [Hadoop](https://hadoop.apache.org/). Intended for non-production use cases like testing out Hive code or running integration tests.

## Usage

```sh
docker run --rm -it -p 10000:10000 hive-mini hiveserver2
```

To connect remotely, use the [JDBC URL](https://cwiki.apache.org/confluence/display/Hive/HiveServer2+Clients#HiveServer2Clients-JDBC) `jdbc:hive2://localhost:10000`. For example:

```sh
beeline -u jdbc:hive2://localhost:10000
```

## Development

```sh
docker build -t weehive:local .

docker run --rm -it -p 10000:10000 weehive:local \
  beeline -u jdbc:hive2:// -e 'show tables;'
```
