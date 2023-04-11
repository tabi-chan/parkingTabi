//
//  main.swift
//  TabiParking
//
//  Created by Tabata Céspedes Figueroa on 28-03-23.
//

import Foundation

//Main Variables and Let
let Menu = """

Bienvenidos al ponedor y sacador de autos XD
TabiParking
--------------------------------------------------------|
Opción [1]: Ingresar Vehículo                           |
Opción [2]: Retirar Vehículo                            |
Opción [3]: Ver Vehículos Estacionados                  |
Opción [4]: Ver Vehículos Retirados y Ganancias         |
Opción [5]: Ver Estacionamientos Disponibles            |
Opción [0]: Salir de esta hermosa consola T-T           |
--------------------------------------------------------|
Por favor ingrese su opción:
"""
var option: String = "0"
var dispo: Bool
var opciones = Funciones()

repeat{
    print(Menu)
    option = readLine() ?? "10"
    switch option {
    case "1":
        dispo = opciones.verificarDisponibilidad()
        if dispo {
            print("Por favor ingrese los datos del Vehículo:")
            print(opciones.ingresarVehiculo())
        } else {
            print("Estacionamiento lleno. Por favor vuelva más tarde")
        }
    case "2":
        if opciones.contarDisponibles() == 20{
            print("No hay autos estacionados para retirar")
        } else {
            print("Por favor indique qué vehículo va a retirar:")
            opciones.retirarVehiculo()
        }
    case "3":
        print("A continuación se muestran los vehículos estacionados:")
        opciones.verVehiculos()
    case "4":
        print("A continuación los vehículos retirados y el monto recaudado:")
        opciones.verRecaudacion()
    case "5":
        print("Estacionamientos disponibles:")
        print(opciones.contarDisponibles())
    case "0":
        print("Vuelve pronto a TabiParking :)")
    default:
        print("Por favor selecciona una opción válida")
    }
    
} while option != "0"
