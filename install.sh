#!/bin/bash

cp k8s-self-hosted-recover /usr/local/bin/
cp k8s-self-hosted-recover.service /etc/systemd/system/

systemctl enable k8s-self-hosted-recover.service
