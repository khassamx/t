import os
import shutil
from datetime import datetime

ORIGEN = "/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media"
DESTINO = os.path.expanduser("~/whatsapp-backup/data")

carpetas = {
    "WhatsApp Images": "images",
    "WhatsApp Video": "videos",
    "WhatsApp Audio": "audios",
    "WhatsApp Voice Notes": "audios",
    "WhatsApp Animated Gifs": "gifs"
}

def organizar_archivo(origen):
    nombre = os.path.basename(origen)

    # ejemplo de nombre: IMG-20240301-WA0001.jpg
    contacto = "desconocido"

    fecha = datetime.now().strftime("%Y-%m-%d")

    carpeta_contacto = os.path.join(DESTINO, contacto, fecha)

    os.makedirs(carpeta_contacto, exist_ok=True)

    destino = os.path.join(carpeta_contacto, nombre)

    if not os.path.exists(destino):
        shutil.copy2(origen, destino)

for carpeta in carpetas:

    ruta = os.path.join(ORIGEN, carpeta)

    if os.path.exists(ruta):

        for archivo in os.listdir(ruta):

            archivo_completo = os.path.join(ruta, archivo)

            if os.path.isfile(archivo_completo):

                organizar_archivo(archivo_completo)

print("Backup terminado")