#!/bin/bash

MYSQL_HOST="localhost"
MYSQL_DUMP="$HOME/wp/dbdumps"

declare -a dbs=(
oneplay_users
oneplay_games
oneplay_cloud
oneplay_career
oneplay_portal
oneplay_social
oneplay_partners
oneplay_notifications
)

runQl() {
  # echo "running: $@"
  mariadb -h "$MYSQL_HOST" -u "$MYSQL_U" "-p$MYSQL_P" -e "$@"
}

runQl "show databases"

for db in "${dbs[@]}"; do
  # runQl "drop database $db"
  # runQl "create database $db"
  # sed -i 's/utf8mb4_0900_ai_ci/utf8_general_ci/g' "$MYSQL_DUMP/$db.sql"
  # sed -i 's/utf8mb3_general_ci/utf8_general_ci/g' "$MYSQL_DUMP/$db.sql"
  # sed -i 's/CHARSET=utf8mb4/CHARSET=utf8/g' "$MYSQL_DUMP/$db.sql"
  # sed -i 's/utf8mb4_0900_ai_ci/utf8mb4_unicode_ci/g' "$MYSQL_DUMP/$db.sql"
  mariadb -h "$MYSQL_HOST" -u "$MYSQL_U" "-p$MYSQL_P" "$db" < "$MYSQL_DUMP/$db.sql"
done



