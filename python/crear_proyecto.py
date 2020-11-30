import os
import paths

def ejecutar(nombre):
    if not os.path.isdir(nombre):
        os.mkdir(nombre)

    os.chdir(nombre)

    if not os.path.isdir(paths.src):
        os.mkdir(paths.src)
    if not os.path.isdir(paths.test):
        os.mkdir(paths.test)
    if not os.path.isdir(paths.config):
        os.mkdir(paths.config)
    if not os.path.isdir(paths.db_script):
        os.mkdir(paths.db_script)

    if not os.path.isfile(paths.global_migraciones):
        file = open(paths.global_migraciones, "w+")
        file.write("--archivo de migraciones temporal")
        file.close

    os.chdir(paths.src)

    if not os.path.isdir(paths.app):
        os.mkdir(paths.app)
    if not os.path.isdir(paths.app_dto):
        os.mkdir(paths.app_dto)
    if not os.path.isdir(paths.app_error):
        os.mkdir(paths.app_error)
    if not os.path.isdir(paths.app_infra):
        os.mkdir(paths.app_infra)
    if not os.path.isdir(paths.app_servicio):
        os.mkdir(paths.app_servicio)
    if not os.path.isdir(paths.app_tipo):
        os.mkdir(paths.app_tipo)
    if not os.path.isdir(paths.app_usecase):
        os.mkdir(paths.app_usecase)
    if not os.path.isdir(paths.app_map):
        os.mkdir(paths.app_map)

    if not os.path.isdir(paths.dominio):
        os.mkdir(paths.dominio)
    if not os.path.isdir(paths.dominio_entidad):
        os.mkdir(paths.dominio_entidad)
    if not os.path.isdir(paths.dominio_error):
        os.mkdir(paths.dominio_error)
    if not os.path.isdir(paths.dominio_servicio):
        os.mkdir(paths.dominio_servicio)
    if not os.path.isdir(paths.dominio_tipo):
        os.mkdir(paths.dominio_tipo)
    
    if not os.path.isdir(paths.infra):
        os.mkdir(paths.infra)
    if not os.path.isdir(paths.infra_broker):
        os.mkdir(paths.infra_broker)
    if not os.path.isdir(paths.infra_db):
        os.mkdir(paths.infra_db)
    if not os.path.isdir(paths.infra_db + 'base/'):
        os.mkdir(paths.infra_db + 'base/')
    if not os.path.isdir(paths.infra_db + 'base/entidad/'):
        os.mkdir(paths.infra_db + 'base/entidad/')
    if not os.path.isdir(paths.infra_hardware):
        os.mkdir(paths.infra_hardware)
    if not os.path.isdir(paths.infra_os):
        os.mkdir(paths.infra_os)

    if not os.path.isdir(paths.common):
        os.mkdir(paths.common)

    os.chdir("..")
    os.chdir(paths.test)

    if not os.path.isdir(paths.app):
        os.mkdir(paths.app)
    if not os.path.isdir(paths.app_usecase):
        os.mkdir(paths.app_usecase)

    if not os.path.isdir(paths.dominio):
        os.mkdir(paths.dominio)
    if not os.path.isdir(paths.dominio_entidad):
        os.mkdir(paths.dominio_entidad)

    os.chdir("..")
    os.chdir(paths.src)