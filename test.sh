#!/bin/bash

set -e

start_time="$(date -u +%s)"

# Hive takes a while to start up
sleep 70

# https://unix.stackexchange.com/a/82610/174664
for i in $(seq 1 8);
do
  [ $i -gt 1 ] && sleep 5
  beeline -u jdbc:hive2://server:10000 -e 'show tables;' \
    && s=0 && break || s=$?
done

end_time="$(date -u +%s)"
elapsed="$(($end_time-$start_time))"
echo "Total of $elapsed seconds"

exit $s
