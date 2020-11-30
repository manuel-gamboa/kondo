import os
import paths

def generarErrorFile(modulo):
    template = open("../../templates/error.template", "r")
    body = template.read()

    body = body.format(
        namespace = paths.app_error.replace("/","."),
        modulo = modulo.capitalize()
    )

    template.close()

    filePath = (
        paths.app_error + paths.app_error.replace("/",".") + modulo.capitalize() + '.pas'
    )

    if not os.path.isfile(filePath):
        file = open(filePath, "w+")
        file.write(body)
        file.close

def generarTiposFile(modulo):
    template = open("../../templates/tipo.template", "r")
    body = template.read()

    body = body.format(
        namespace = paths.app_tipo.replace("/","."),
        modulo = modulo.capitalize()
    )

    template.close()

    filePath = (
        paths.app_tipo + paths.app_tipo.replace("/",".") + modulo.capitalize() + '.pas'
    )

    if not os.path.isfile(filePath):
        file = open(filePath, "w+")
        file.write(body)
        file.close

def generarInfraFile(modulo):
    template = open("../../templates/app_infra.template", "r")
    body = template.read()

    body = body.format(
        namespace = paths.app_infra.replace("/","."),
        modulo = modulo.capitalize()
    )

    template.close()

    filePath = (
        paths.app_infra + paths.app_infra.replace("/",".") + modulo.capitalize() + '.pas'
    )

    if not os.path.isfile(filePath):
        file = open(filePath, "w+")
        file.write(body)
        file.close

def generarAppFolders(modulo):
    if not os.path.isdir(paths.app_usecase + modulo):
        os.mkdir(paths.app_usecase + modulo)
    if not os.path.isdir(paths.app_dto + modulo):
        os.mkdir(paths.app_dto + modulo)
    if not os.path.isdir(paths.app_infra + modulo):
        os.mkdir(paths.app_infra + modulo)

def generarAppFiles(modulo):
    generarTiposFile(modulo)
    generarErrorFile(modulo)    
        
def generarDominioFolders(modulo):
    if not os.path.isdir(paths.dominio_entidad + modulo):
        os.mkdir(paths.dominio_entidad + modulo)

def generarInfraFolders(modulo):
    if not os.path.isdir(paths.infra_db + modulo):
        os.mkdir(paths.infra_db + modulo)

def generarTestFolders(modulo):
    os.chdir("..")
    os.chdir(paths.test)

    if not os.path.isdir(paths.app_usecase + modulo):
        os.mkdir(paths.app_usecase + modulo)
    if not os.path.isdir(paths.dominio_entidad + modulo):
        os.mkdir(paths.dominio_entidad + modulo)

    os.chdir("..")
    os.chdir(paths.src)

def ejecutar(nombre):
    generarAppFolders(nombre)
    generarAppFiles(nombre)
    generarDominioFolders(nombre)
    generarInfraFolders(nombre)
    generarTestFolders(nombre)
    

    