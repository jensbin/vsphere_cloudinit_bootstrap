#!/usr/bin/env bash

#
# get image: curl -LO https://stable.release.core-os.net/amd64-usr/current/coreos_production_vmware_ova.ova
#
#cat <file-name> | gzip | base64 -w0


OVFTOOL="ovftool"
BOXNAME="gujtest"

VCENTER="vi://vcenter.vmware.net/DC/host/int-san"

CLOUDCONFIG="$(cat cloud-config.yaml | gzip | base64 -w0)"
#CLOUDCONFIG="$(cat ignition.json | gzip | base64 -w0)"


$OVFTOOL --name=$BOXNAME \
  --diskMode=eagerZeroedThick \
  --network=NETWORK \
  --vmFolder=/DC/gujtest \
  --datastore=DC1SAN01 \
  --X:waitForIp --powerOn \
  --X:guest:"coreos.config.data=${CLOUDCONFIG}" \
  --X:guest:"coreos.config.data.encoding=gzip+base64" \
  coreos_production_vmware_ova.ova \
  $VCENTER
