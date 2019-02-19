# R example code

1. [Start the Hive server.](../../README.md#remote-connection)
1. Download [Hadoop](https://hadoop.apache.org/releases.html) and [Hive](https://hive.apache.org/downloads.html), and extract to the top level of this repository.
   - You may need to change the `.jar` paths in [the script](test.R) to match the paths/versions.
1. From this directory, run:

   ```sh
   R --no-save < test.R
   ```
