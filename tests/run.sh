#!/bin/bash
echo "Starting tests" >&1

mkdir /tmp/test
echo "{\"action\": \"dump\"}" > /tmp/test/config.json

php /code/src/run.php --data=/tmp/test | grep "{\"output\":\"ok\"}"
if [ $? -eq 0 ]
then
  echo "ok"
else
  echo "Invalid output" >&2
  exit 1
fi


echo "{\"action\": \"another\"}" > /tmp/test/config.json
php /code/src/run.php --data=/tmp/test
if [ $? -eq 1 ]
then
  echo "ok"
else
  echo "Exit code should be 1" >&2
  exit 1
fi
