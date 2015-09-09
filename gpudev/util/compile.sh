#!/bin/bash
source args.sh
cd $DIR

if [[ "$1" == "clean" ]]; then
    CLEAN_ARGS=clean
    shift 1
fi

if [[ "$1" != "full" ]]; then
    SKIP_MODULES='-pl !examples,!assembly,!extras/kinesis-asl-assembly,!external/flume-assembly,!external/kafka-assembly'
else
    shift 1
fi

killZinc
$MVN_CMD -T $MVN_COMPILE_PARALLEL_THREADS $MVN_ARGS $SKIP_MODULES -DskipTests $CLEAN_ARGS package $@ 2>&1 | tee ~/compile.txt
