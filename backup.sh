mkdir -p ~/whatsapp-backup/data && cd ~/whatsapp-backup && \
echo 'import os
import shutil
from datetime import datetime
import json
import subprocess

ORIGEN="/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media"
DESTINO=os.path.expanduser("~/whatsapp-backup/data")
carpetas={"WhatsApp Images":"images","WhatsApp Video":"videos","WhatsApp Audio":"audios","WhatsApp Voice Notes":"audios","WhatsApp Animated Gifs":"gifs"}
PREFIJOS={"+34":"🇪🇸","+595":"🇵🇾","+54":"🇦🇷","+1":"🇺🇸","+52":"🇲🇽","+44":"🇬🇧"}
def obtener_contactos():
    try:
        resultado=subprocess.check_output(["termux-contact-list"])
        contactos=json.loads(resultado)
    except:
        return {}
    agenda={}
    for c in contactos:
        nombre=c.get("name","desconocido")
        numeros=c.get("phoneNumbers",[])
        for n in numeros:
            numero=n["number"].replace(" ","").replace("-","")
            prefijo="🌐"
            for code in PREFIJOS:
                if numero.startswith(code):
                    prefijo=PREFIJOS[code]
                    break
            agenda[numero]=f"{prefijo}{nombre}"
    return agenda
agenda=obtener_contactos()
def obtener_nombre_contacto(numero):
    for n in agenda:
        if n in numero or numero in n:
            return agenda[n]
    return "🌐desconocido"
def guardar_archivo(archivo, carpeta_destino):
    nombre_contacto=obtener_nombre_contacto("unknown")
    fecha=datetime.now().strftime("%Y-%m-%d")
    carpeta_contacto=os.path.join(carpeta_destino,nombre_contacto,fecha)
    os.makedirs(carpeta_contacto,exist_ok=True)
    destino=os.path.join(carpeta_contacto,os.path.basename(archivo))
    if not os.path.exists(destino):
        shutil.copy2(archivo,destino)
for c in carpetas:
    ruta=os.path.join(ORIGEN,c)
    if os.path.exists(ruta):
        for f in os.listdir(ruta):
            archivo=os.path.join(ruta,f)
            if os.path.isfile(archivo):
                guardar_archivo(archivo,DESTINO)
print("Backup organizado por contactos con prefijo terminado")' > backup.py && \
echo '#!/data/data/com.termux/files/usr/bin/bash
cd ~/whatsapp-backup
python backup.py
git add .
git commit -m "Backup automático $(date +%Y-%m-%d_%H:%M:%S)"
git push origin main
echo "Backup y GitHub completado"' > run.sh && \
chmod +x backup.py run.sh