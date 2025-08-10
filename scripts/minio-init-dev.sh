#!/bin/bash
set -e
export $(grep -v '^#' .env | xargs)

exec-s3() {
    docker compose --file=./docker-compose.dev.yml exec s3 $@
}

exec-s3 mc alias rm local
exec-s3 mc alias s local http://localhost:9000 "${AWS_ACCESS_KEY_ID}" "${AWS_SECRET_ACCESS_KEY}"
exec-s3 mc mb local/repair-wiki
exec-s3 mc anonymous set download local/repair-wiki
