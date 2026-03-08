import os
import shutil
from datetime import datetime
from contacts import obtener_contactos

ORIGEN="/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media"
DESTINO=os.path.expanduser("~/whatsapp-backup/data")

agenda = obtener_contactos()

def nombre_contacto(numero):

    for n in agenda:
        if n in numero:
            return agenda[n]

    return "desconocido"

def guardar_archivo(ruta):

    numero="unknown"

    nombre=nombre_contacto(numero)

    fecha=datetime.now().strftime("%Y-%m-%d")

    carpeta=os.path.join(DESTINO,nombre,fecha)

    os.makedirs(carpeta,exist_ok=True)

    archivo=os.path.basename(ruta)

    destino=os.path.join(carpeta,archivo)

    if not os.path.exists(destino):

        shutil.copy2(ruta,destino)

for carpeta in os.listdir(ORIGEN):

    ruta=os.path.join(ORIGEN,carpeta)

    if os.path.isdir(ruta):

        for f in os.listdir(ruta):

            archivo=os.path.join(ruta,f)

            if os.path.isfile(archivo):

                guardar_archivo(archivo)

print("Backup organizado por contactos")