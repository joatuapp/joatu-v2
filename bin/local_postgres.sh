#!/bin/bash
f=`dirname "$0"`
POSTGRESQL_DATA="$f/../vendor/postgresql"

if [ ! -d $POSTGRESQL_DATA ]; then
    mkdir -p $POSTGRESQL_DATA
    initdb -D $POSTGRESQL_DATA
fi

exec postgres -D $POSTGRESQL_DATA
