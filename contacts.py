import json
import subprocess

def obtener_contactos():

    resultado = subprocess.check_output(["termux-contact-list"])

    contactos = json.loads(resultado)

    agenda = {}

    for c in contactos:

        nombre = c.get("name","desconocido")

        numeros = c.get("phoneNumbers",[])

        for n in numeros:

            numero = n["number"].replace(" ","")

            agenda[numero] = nombre

    return agenda