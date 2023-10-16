#!/bin/sh

FERRETDB_VERSION=$1
FERRETDB_PORT=$2
FERRETDB_TELEMETRY=$3
USE_POSTGRES=$4

echo "Starting FerretDB version ${FERRETDB_VERSION} on port ${FERRETDB_PORT}"

if [ "$USE_POSTGRES" = "true" ]; then
  echo "Starting FerretDB with Postgres"

  docker network create ferretdb

  docker run --network ferretdb --name postgres \
    -e POSTGRES_USER=username \
    -e POSTGRES_PASSWORD=password \
    -e POSTGRES_DB=ferretdb \
    -d postgres

  docker run --network ferretdb --name ferretdb \
    -p $FERRETDB_PORT:27017 \
    -e FERRETDB_POSTGRESQL_URL=postgres://username:password@postgres:5432/ferretdb?pool_max_conns=40 \
    -e FERRETDB_TELEMETRY=$FERRETDB_TELEMETRY \
    -d ghcr.io/ferretdb/ferretdb:$FERRETDB_VERSION
else
  echo "Starting FerretDB with sqlite"

  docker run --network ferretdb --name ferretdb \
    -p $FERRETDB_PORT:27017 \
    -e FERRETDB_HANDLER=sqlite \
    -e FERRETDB_SQLITE_URL=file:./ \
    -e FERRETDB_TELEMETRY=$FERRETDB_TELEMETRY \
    -d ghcr.io/ferretdb/ferretdb:$FERRETDB_VERSION
fi

if [ $? -ne 0 ]; then
  echo "Error starting FerretDB Docker container"
  exit 2
fi
