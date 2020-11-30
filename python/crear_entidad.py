import emoji
import paths
import os
import db_types_map
import db_commands
from termcolor import colored

def generarDTO(entidad, modulo, campos):
    template = open("../../templates/dto.template", "r")
    body = template.read()
    fields = ''
    properties = ''

    campos.insert(0, "Id:Integer")

    for campo in campos:
        campoTemp = campo.split(":")[0] + ": " + campo.split(":")[1]

        fields = fields + "f" + campoTemp + ";\n      "
        properties = properties + "property {campo} read f{field} write f{field};\n      ".format(
            campo = campoTemp,
            field = campoTemp.split(":")[0]
        )

    body = body.format(
        app_dto = paths.app_dto.replace("/","."),
        entidad = entidad.capitalize(),
        modulo = modulo,
        uses_block = "spring.collections;",
        fields_block = fields,
        properties_block = properties
    )

    template.close()

    return body

def generarEntity(entidad, modulo, campos):
    template = open("../../templates/entity.template", "r")
    body = template.read()
    fields = ''
    properties = ''
    constructor = 'constructor Create(\n        '
    constructor_arguments = ''
    constructor_asign = ''

    for campo in campos:
        campoTemp = campo.split(":")[0] + ": " + campo.split(":")[1]

        fields = fields + "f" + campoTemp + ";\n      "
        constructor = constructor + "a" + campoTemp +";\n        "
        constructor_arguments = constructor_arguments + "a" + campoTemp +";\n  "
        constructor_asign += (
            "Set" + campoTemp.split(":")[0] + "(a" + campoTemp.split(":")[0] +");\n  "
        )
        properties = properties + "property {campo} read f{field} write Set{field};\n      ".format(
            campo = campoTemp,
            field = campoTemp.split(":")[0]
        )

    body = body.format(
        domain_entity = paths.dominio_entidad.replace("/","."),
        entidad = entidad.capitalize(),
        modulo = modulo,
        uses_block = "spring.collections;",
        fields_block = fields,
        properties_block = properties,
        constructor_block = constructor.strip()[0:-1] + "\n      );",
        constructor_args = constructor_arguments.strip()[0:-1],
        constructor_asign = constructor_asign
    )

    template.close()

    return body

def generarDBScript(entidad, campos):
    template = open("../../templates/db_script.template", "r")
    body = template.read()
    fields = ''
    constraints = ''

    for campo in campos:

        #precondicion
        if (len(campo.split(":")) > 2) and (campo.split(":")[2] == db_commands.IGNORE):
            continue
        
        if campo.split(":")[0].lower() == "id":
            constraints = constraints + "constraint pk_" + entidad + " primary key (Id),\n  "

        fields = fields + "{campo} {tipo},\n  ".format(
            campo = campo.split(":")[0],
            tipo = (db_types_map.data_types[campo.split(":")[1]]).strip()
        )

        #solo si existen parametros de base de datos, es decir mas de 2 parametros
        if len(campo.split(":")) > 2 and \
           (campo.split(":")[2].split("->")[0] == db_commands.FOREIGN_KEY):

            referencia = campo.split(":")[2].split("->")[1]

            constraints = ( 
                constraints + 
                "constraint fk_{entidad}_{ref} foreign key ({campo}) references {ref}(Id),\n  ".format(
                    entidad = entidad,
                    ref = referencia,
                    campo = campo.split(":")[0]
                )  
            )            

    fields += constraints

    body = body.format(
        entidad = entidad.capitalize(),
        fields_block = fields.strip()[0:-1],
    )

    template.close()

    return body

def generarSpec(entidad, modulo):
    template = open("../../templates/spec.template", "r")
    body = template.read()
    
    body = body.format(
        sujeto = entidad.capitalize(),
        namespace = paths.dominio_entidad.replace("/",".") + modulo + ".",
    )

    template.close()

    filepath = (
        "../" + paths.test + "/" +
        paths.dominio_entidad + modulo + '/' +
        entidad.capitalize() + 'Spec.pas'
    )

    if not os.path.isfile(filepath):
        file = open(filepath, "w+")
        file.write(body)
        file.close 

def generarDatabaseEntity(entidad, modulo, campos):
    template = open("../../templates/db_entity.template", "r")
    body = template.read()
    fields = ''
    properties = ''

    for campo in campos:
        #precondicion
        if (len(campo.split(":")) > 2) and (campo.split(":")[2] == db_commands.IGNORE):
            continue

        campoTemp = campo.split(":")[0] + ": " + campo.split(":")[1]

        if campo.split(":")[0].lower() == "id":
            fields += "[Column('Id', [TColumnProp.Unique, TColumnProp.Required, TColumnProp.NoUpdate])]\n      "
        else:
            fields = fields + "[Column('{campo}')]\n      ".format(campo = campoTemp.split(":")[0])
       
        fields = fields + "f" + campoTemp + ";\n      "

        properties = properties + "property {campo} read f{field} write f{field};\n      ".format(
            campo = campoTemp,
            field = campoTemp.split(":")[0]
        )

    body = body.format(
        namespace = "orm.entidad",
        entidad = entidad.capitalize(),
        modulo = modulo,
        fields_block = fields,
        properties_block = properties
    )

    template.close()

    return body

def generarRepositorio(entidad, modulo):
    template = open("../../templates/repository.template", "r")
    body = template.read()
    
    body = body.format(
        entidad = entidad.capitalize(),
        namespace = paths.infra_db.replace("/","."),
        modulo = modulo,
        domain_namespace = paths.dominio_entidad.replace("/",".")
    )

    template.close()

    return body

def ejecutar(args, modulo):
    nombre = args[1]
    campos = []
    continuar = True

    while continuar:
        print(colored("  Campo: ", 'blue') , end = '')
        campo = input()
        if campo != "":
            campos.append(campo)
        else:
            continuar = False

    print("  Generar Repositorio\U00002753(y/n)", end = '')
    generarRepo = input() 

    filepath = (
        paths.app_dto + modulo + '/' +
        paths.app_dto.replace("/",".") + modulo + '.Datos' + 
        nombre.capitalize() + '.pas'
    )

    if not os.path.isfile(filepath):
        file = open(filepath, "w+")
        file.write(generarDTO(nombre, modulo, campos))
        file.close

    filepath = (
        paths.dominio_entidad + modulo + '/' + 
        paths.dominio_entidad.replace("/",".") + modulo + '.' + 
        nombre.capitalize() + '.pas'
    )

    if not os.path.isfile(filepath):
        file = open(filepath, "w+")
        file.write(generarEntity(nombre, modulo, campos))
        file.close

    filepath = (
        paths.infra_db + 'base/entidad/' + 
        "orm.entidad." + 
        nombre.capitalize() + '.pas'
    )
    if not os.path.isfile(filepath):
        file = open(filepath, "w+")
        file.write(generarDatabaseEntity(nombre, modulo, campos))
        file.close

    if generarRepo == "y":
        filepath = (
            paths.infra_db + modulo + '/' + 
            paths.infra_db.replace("/",".") + modulo + '.Repositorio' + 
            nombre.capitalize() + '.pas'
        )
        if not os.path.isfile(filepath):
            file = open(filepath, "w+")
            file.write(generarRepositorio(nombre, modulo))
            file.close

    generarSpec(nombre,modulo)

    if os.path.isfile('../' + paths.global_migraciones):
        file = open('../' + paths.global_migraciones, "a")
        file.write("\n\n")
        file.write(generarDBScript(nombre, campos))
        file.close