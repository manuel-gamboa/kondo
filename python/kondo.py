import os
import emoji
from termcolor import colored

import crear_proyecto
import crear_modulo
import crear_entidad
import crear_usecase

proyecto_ = ''
modulo_ = ''
entidad_ = ''
usecase_ = ''

def main():
    print('Kondo 0.1.0')
    print('')
    #print(emoji.emojize(':question:'))
    continuar = True
    global proyecto_
    global modulo_
    global entidad_
    global usecase_

    while continuar:
        if modulo_ != '':
            print(colored("\U000021AA " + proyecto_ + "/" + modulo_, 'green'))
        elif proyecto_ != '':
            print(colored("\U000021AA " + proyecto_, 'green'))
        
        print(colored("λ ","magenta"), end = '')

        comando = input()
        args = comando.split() 

        if (args[0] == "modulo") or (args[0] == "m"):
            modulo_ = args[1]
            crear_modulo.ejecutar(modulo_)
        elif (args[0] == "entidad") or (args[0] == "e"):
            print(colored("\U000021AA " + proyecto_ + "/" + modulo_ + "/" + args[1], 'green'))
            crear_entidad.ejecutar(args, modulo_)
        elif (args[0] == "usecase") or (args[0] == "u"):
            print(colored("\U000021AA " + proyecto_ + "/" + modulo_ + "/" + args[1], 'green'))
            crear_usecase.ejecutar(args, modulo_)
        elif (args[0] == "proyecto") or (args[0] == "p"):
            proyecto_ = args[1]
            crear_proyecto.ejecutar(proyecto_)
        elif args[0] == "exit":
            continuar = False

main()
    


