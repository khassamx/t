import os
import shutil
from datetime import datetime
from contacts import obtener_contactos

# Carpeta origen de WhatsApp
ORIGEN = "/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media"

# Carpeta destino del backup
DESTINO = os.path.expanduser("~/whatsapp-backup/data")

# Carpetas de WhatsApp a respaldar
carpetas = {
    "WhatsApp Images": "images",
    "WhatsApp Video": "videos",
    "WhatsApp Audio": "audios",
    "WhatsApp Voice Notes": "audios",
    "WhatsApp Animated Gifs": "gifs"
}

# Cargar contactos con prefijos
agenda = obtener_contactos()

def obtener_nombre_contacto(numero):
    """
    Devuelve el nombre del contacto con prefijo si existe, sino "desconocido"
    """
    for n in agenda:
        if n in numero or numero in n:
            return agenda[n]
    return "🌐desconocido"

def guardar_archivo(archivo, carpeta_destino):
    numero = "unknown"  # Para detectar número real, se puede mejorar con metadata si existiera
    nombre_contacto = obtener_nombre_contacto(numero)
    fecha = datetime.now().strftime("%Y-%m-%d")
    carpeta_contacto = os.path.join(carpeta_destino, nombre_contacto, fecha)
    os.makedirs(carpeta_contacto, exist_ok=True)
    destino = os.path.join(carpeta_contacto, os.path.basename(archivo))
    if not os.path.exists(destino):
        shutil.copy2(archivo, destino)

# Iterar sobre carpetas y archivos
for c in carpetas:
    ruta = os.path.join(ORIGEN, c)
    if os.path.exists(ruta):
        for f in os.listdir(ruta):
            archivo = os.path.join(ruta, f)
            if os.path.isfile(archivo):
                guardar_archivo(archivo, DESTINO)

print("Backup organizado por contactos con prefijo terminado")