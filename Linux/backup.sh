#!/bin/bash

sudo mkdir -p /var/backup
sudo tar cvf /var/backup/home.tar /home
sudo mv /var/backup/home.tar /var/back/home.20200101.tar
tar cvf /var/backkup/home.tar /home
ls -lh /var/backup > /var/backup/file_report.txt
free -h > /var/backup/disk_report.txt
