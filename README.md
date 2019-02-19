# WeeHive

A minimal-as-possible Docker container running [Apache Hive](https://hive.apache.org/) on [Hadoop](https://hadoop.apache.org/). Intended for non-production use cases like testing out Hive code or running integration tests.

## Setup

1. Install Docker.
1. Make sure that you have at least a few GB of memory allocated to Docker. Instructions:
   - [Docker for Mac](https://docs.docker.com/docker-for-mac/#advanced)
   - [Docker for Windows](https://docs.docker.com/docker-for-windows/#advanced)
1. Clone this repository.
1. From the repository root, build the Docker image.

   ```sh
   docker build -t weehive .
   ```

## Usage

### Beeline

```sh
docker run --rm -it \
  -v weehive_hadoop:/usr/local/hadoop/warehouse \
  -v weehive_meta:/usr/local/hadoop/metastore_db \
  weehive
```

You will be shown the [Beeline](https://cwiki.apache.org/confluence/display/Hive/HiveServer2+Clients#HiveServer2Clients-Beeline%E2%80%93CommandLineShell) shell. The `weehive_hadoop` and `weehive_meta` [volume names](https://docs.docker.com/storage/volumes/#choose-the--v-or---mount-flag) can be changed to be project-specific names if you want.

### Remote connection

1. Run the server.

   ```sh
   docker run --rm -it -p 10000:10000 \
     -v weehive_hadoop:/usr/local/hadoop/warehouse \
     -v weehive_meta:/usr/local/hadoop/metastore_db \
     weehive hiveserver2
   ```

1. Wait ~90 seconds for Hive to fully start.
1. Connect using the [JDBC URL](https://cwiki.apache.org/confluence/display/Hive/HiveServer2+Clients#HiveServer2Clients-JDBC) `jdbc:hive2://localhost:10000`. Example from an external `beeline`:

   ```sh
   beeline -u jdbc:hive2://localhost:10000
   ```

## Loading data from file

1. [Mount the data as a volume](https://docs.docker.com/storage/volumes/#start-a-container-with-a-volume) by adding a `-v <sourcedir>:/usr/local/hadoop/data` to one of the `docker run` commands above.
1. Follow [instructions to load data](https://cwiki.apache.org/confluence/display/Hive/Tutorial#Tutorial-LoadingData)

## Development

```sh
docker build -t weehive:local .
docker run --rm -it weehive:local
```
