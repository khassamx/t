#!/data/data/com.termux/files/usr/bin/bash

cd ~/whatsapp-backup
python backup.py

git add .
git commit -m "Backup automático $(date '+%Y-%m-%d %H:%M:%S')"
git push origin main

echo "Backup y GitHub completado"