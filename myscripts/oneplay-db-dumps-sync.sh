#!/bin/bash

MYSQL_HOST="localhost"
MYSQL_DUMP="$HOME/wp/sqldumps"

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
  runQl "drop database $db"
  runQl "create database $db"
  mariadb -h "$MYSQL_HOST" -u "$MYSQL_U" "-p$MYSQL_P" "$db" < "$MYSQL_DUMP/$db.sql"
done

