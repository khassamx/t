import json
import subprocess

# Mapa de prefijos por país (ejemplo)
PREFIJOS = {
    "+34": "🇪🇸",
    "+595": "🇵🇾",
    "+54": "🇦🇷",
    "+1": "🇺🇸",
    "+52": "🇲🇽",
    "+44": "🇬🇧",
    # agrega más prefijos según necesites
}

def obtener_contactos():
    """
    Obtiene la lista de contactos desde Termux y devuelve un diccionario
    con clave = número completo y valor = nombre con prefijo de país
    """
    try:
        resultado = subprocess.check_output(["termux-contact-list"])
        contactos = json.loads(resultado)
    except Exception as e:
        print("Error al obtener contactos:", e)
        return {}

    agenda = {}

    for c in contactos:
        nombre = c.get("name","desconocido")
        numeros = c.get("phoneNumbers",[])
        for n in numeros:
            numero = n["number"].replace(" ","").replace("-","")
            prefijo = "🌐"  # default si no se encuentra
            for code in PREFIJOS:
                if numero.startswith(code):
                    prefijo = PREFIJOS[code]
                    break
            agenda[numero] = f"{prefijo}{nombre}"

    return agenda