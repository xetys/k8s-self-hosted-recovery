#!/bin/bash

systemctl disable k8s-self-hosted-recover.service

rm /usr/local/bin/k8s-self-hosted-recover
rm /etc/systemd/system/k8s-self-hosted-recover.service

