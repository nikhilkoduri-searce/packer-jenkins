#!/bin/bash -x
sudo yum -y update
sudo yum install -y java-11-openjdk-devel
sudo mv /tmp/java-app.service /etc/systemd/system/java-app.service
sudo systemctl enable java-app.service
sudo systemctl start java-app.service
