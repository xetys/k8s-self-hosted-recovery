#!/bin/bash

cp k8s-self-hosted-recover /usr/local/bin/
cp k8s-self-hosted-recover.service /etc/systemd/system/

chmod 755 /usr/local/bin/k8s-self-hosted-recover

systemctl enable k8s-self-hosted-recover.service
