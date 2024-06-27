#!/bin/bash

# Start all 3 cluster
pushd nats1
if [ -d "data" ]; then
  rm -r "data"
fi
nats-server --config nats.conf -l output.log &
echo $!>pid
popd
pushd nats2
if [ -d "data" ]; then
  rm -r "data"
fi
nats-server --config nats.conf -l output.log &
echo $!>pid
popd
pushd nats3
if [ -d "data" ]; then
  rm -r "data"
fi
nats-server --config nats.conf -l output.log &
echo $!>pid
popd

echo "Sleeping 5s"
sleep 3 

echo "Nats Server nats1, nats2 and nats3 started"
nats --creds sys.creds server report jsz

##########
echo "Rename nats3"
pushd nats3
kill `cat pid`
nats-server --config nats-rename.conf -l output.log &
echo $!>pid
popd

echo "Sleeping 5s"
sleep 5

echo "Nats Server nats1, nats2 and nats30 started"
nats --creds sys.creds server report jsz


##########
echo "Rename nats2"
pushd nats2
kill `cat pid`
nats-server --config nats-rename.conf -l output.log &
echo $!>pid
popd

echo "Sleeping 5s"
sleep 5

echo "Nats Server nats1, nats20 and nats30 started"
nats --creds sys.creds server report jsz


##########
echo "Rename nats1"
pushd nats1
kill `cat pid`
nats-server --config nats-rename.conf -l output.log &
echo $!>pid
popd

echo "Sleeping 5s"
sleep 5

echo "Nats Server nats10, nats20 and nats30 started"
nats --creds sys.creds server report jsz

####
echo "Start renaming back"
####

####
echo "Rename nats1 back"
pushd nats1
kill `cat pid`
nats-server --config nats.conf -l output.log &
echo $!>pid
popd

echo "Sleeping 5s"
sleep 5

echo "Nats Server nats1, nats20 and nats30 started"
nats --creds sys.creds server report jsz

####
echo "Rename nats2 back"
pushd nats2
kill `cat pid`
nats-server --config nats.conf -l output.log &
echo $!>pid
popd

echo "Sleeping 5s"
sleep 5

echo "Nats Server nats1, nats2 and nats30 started"
nats --creds sys.creds server report jsz

####
echo "Rename nats3 back"
pushd nats3
kill `cat pid`
nats-server --config nats.conf -l output.log &
echo $!>pid
popd

echo "Sleeping 5s"
sleep 5

echo "Nats Server nats1, nats2 and nats3 started"
nats --creds sys.creds server report jsz

echo "Nats Servers are still running on ports 4222, 4223 and 4224"