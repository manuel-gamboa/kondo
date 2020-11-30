import emoji
import paths
import os
from termcolor import colored

def llenarTemplate(nombre, modulo):
    template = open("../../templates/usecase.template", "r")
    body = template.read()

    items = os.listdir(paths.infra_db + modulo + "/")
    repositorios = ''
    constructor_args = ''
    constructor_assignment = ''
    pathParts = []

    for item in items:  
        if os.path.isfile(paths.infra_db + modulo + "/" + item) and "Repositorio" in item:
            pathParts = item.split(".")
            repo = pathParts[len(pathParts) - 2]

            repositorios += "f{repo}: I{repo};\n      ".format(
                repo = repo
            )

            constructor_args += "const a{repo}: I{repo};\n        ".format(
                repo = repo
            )

            constructor_assignment += "f{repo} := a{repo};\n  ".format(
                repo = repo
            )   
    
    body = body.format(
        usecase = nombre[:1].upper() + nombre[1:],
        app_usecase = paths.app_usecase.replace("/","."),
        modulo = modulo,
        app_infra = paths.app_infra.replace("/","."),
        app_tipos = paths.app_tipo.replace("/","."),
        app_error = paths.app_error.replace("/","."),
        block_repositorios = repositorios,
        block_constructor_assignment = constructor_assignment,
        constructor_args = constructor_args.strip()
    )

    template.close()

    return body

def ejecutar(args, modulo):
    nombre = args[1]
    filepath = (
        paths.app_usecase + modulo + '/' +
        paths.app_usecase.replace("/",".") + modulo + '.' + 
        nombre[:1].upper() + nombre[1:] + '.pas'
    )

    if not os.path.isfile(filepath):
        file = open(filepath, "w+")
        file.write(llenarTemplate(nombre, modulo))
        file.close