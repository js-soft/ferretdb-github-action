#!/bin/sh

FERRETDB_VERSION=$1
FERRETDB_PORT=$2
FERRETDB_TELEMETRY=$3

echo "Starting FerretDB version ${FERRETDB_VERSION} on port ${FERRETDB_PORT}"

docker network create ferretdb

docker run --network ferretdb --name postgres \
  -e POSTGRES_USER=username \
  -e POSTGRES_PASSWORD=password \
  -e POSTGRES_DB=postgres \
  -d ghcr.io/ferretdb/postgres-documentdb:latest

docker run --network ferretdb --name ferretdb \
  -p $FERRETDB_PORT:27017 \
  -e FERRETDB_POSTGRESQL_URL=postgres://username:password@postgres:5432/postgres?pool_max_conns=40 \
  -e FERRETDB_TELEMETRY=$FERRETDB_TELEMETRY \
  -e FERRETDB_AUTH=false \
  -d ghcr.io/ferretdb/ferretdb:$FERRETDB_VERSION

if [ $? -ne 0 ]; then
  echo "Error starting FerretDB Docker container"
  exit 2
fi
