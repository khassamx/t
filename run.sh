#!/data/data/com.termux/files/usr/bin/bash

# Carpeta del proyecto
cd ~/whatsapp-backup

# Ejecutar Python backup
python backup.py

# Subir automáticamente a GitHub
git add .
git commit -m "Backup automático $(date '+%Y-%m-%d %H:%M:%S')"
git push origin main

echo "Backup y GitHub completado con éxito"