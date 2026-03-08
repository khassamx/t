#!/bin/bash

while true
do

python backup.py

cd ~/whatsapp-backup

git add .
git commit -m "backup $(date)"
git push origin main

sleep 60

done