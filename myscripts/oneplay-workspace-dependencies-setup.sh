#!/bin/bash

LC_ELASTICSEARCH_HOME="/media/win/d/linux/elasticsearch-8.8.1"

declare -a services=("redis" "mariadb" "mongodb");
declare -a apps=(
# "mongodb-compass"
# "insomnia-designer"
# "google-chrome-stable"
);

for service in "${services[@]}"; do
  if ! systemctl is-active --quiet "$service"; then
    echo "starting: $service.service";
    sudo systemctl start "$service.service";
  else
    echo "$service.service is running!";
  fi
done

for app in "${apps[@]}"; do
  if ! (ps -aux | rg "$app" | rg -v "rg" &> /dev/null) then
    echo "starting $app";
    ("$app" &> /dev/null &)
  else
    echo "$app is running!";
  fi
done

# (mingo &> /dev/null &)
# mongodb-compass &> /dev/null &
# (google-chrome-stable &> /dev/null &)
# (insomnia-designer --in-process-gpu &> /dev/null &)

# run elasticsearch
elastic_is_running() {
  # curl -k -X GET "https://opdev:oneplay@localhost:9200/_nodes/_all/jvm?pretty"
  (curl "http://localhost:9200" &> /dev/null)
  if [ "$?" == 52 ]; then
    return 0;
  else
    return 1;
  fi
}

# is_elastic_running;
# (curl "http://localhost:9200" &> /dev/null)
# if [ "$?" != 52 ]; then
if ! elastic_is_running; then
  echo "starting elasticsearch";
  /bin/bash "$LC_ELASTICSEARCH_HOME/bin/elasticsearch";
  # (/bin/bash "$LC_ELASTICSEARCH_HOME/bin/elasticsearch" &)
  # (/bin/bash "$LC_ELASTICSEARCH_HOME/bin/elasticsearch" &> /dev/null &)
else
  echo "elasticsearch is running!";
fi

