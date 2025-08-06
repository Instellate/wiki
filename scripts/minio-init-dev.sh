#!/bin/bash
set -e
export $(grep -v '^#' .env | xargs)

exec() {
    docker compose --file=./docker-compose.dev.yml exec s3 $@
}

exec mc alias rm local
exec mc alias s local http://localhost:9000 "${AWS_ACCESS_KEY_ID}" "${AWS_SECRET_ACCESS_KEY}"
exec mc mb local/repair-wiki
exec mc anonymous set download local/repair-wiki
