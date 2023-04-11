//
//  functions.swift
//  TabiParking
//
//  Created by Tabata Céspedes Figueroa on 28-03-23.
//

import Foundation

class Funciones {
    // MARK: Atributos
    var estacionamiento = Parking()
    // MARK: Ciclo vida
/*    init(estacionamiento: Parking) {
        self.estacionamiento = estacionamiento
    }
 */
    // MARK: Funciones
    func verVehiculos() {
        estacionamiento.visualizarVehiculos()
    }
    
    func ingresarVehiculo() -> String {

        var patenteIn: String = ""
        var tipoIn: String = ""
        var tipoVeh: tipoVehi = .Otro
        var horaIn: String = ""
        let listadoTipo: String = """
        Indique el número que corresponda al tipo del Vehículo:
         [1] Auto
         [2] Moto
         [3] Minibus
         [4] Bus
         Por favor ingrese una opción:
    """
        repeat {
            print("Patente:")
            patenteIn = readLine() ?? ""
            if patenteIn == ""{
                print("Por favor ingrese una opción válida. Si desea salir ingrese '000000'")
            }else if patenteIn.contains("000000") == true {
                print("Has salido del ingreso de Patente")
                tipoIn = "6"
                break
            }
        } while patenteIn == ""
        patenteIn = patenteIn.uppercased()
        if estacionamiento.verificarVehiculo(patenteValidar: patenteIn) {
            print("El vehículo ya existe. Volverá al menú principal")
            return ""
        }
        
        if tipoIn != "6" {
            repeat {
                print(listadoTipo)
                tipoIn = readLine() ?? ""
                switch tipoIn {
                case "1":
                    tipoVeh = .Auto
                case "2":
                    tipoVeh = .Moto
                case "3":
                    tipoVeh = .Minibus
                case "4":
                    tipoVeh = .Bus
                case "5":
                    print("Has salido del ingreso de Tipo de Vehículo. No se ha ingresado el vehículo. Volverás al menú principal")
                    tipoIn = "6"
                    break
                default:
                    print("Por favor ingrese una opción válida. Si desea salir ingrese '5'")
                }
            } while tipoIn == ""
            if tipoIn != "6" {
                repeat {
                    print("Ingrese hora de ingreso:")
                    horaIn = readLine() ?? ""
                    if horaIn == "" {
                        print("Si desea salir, ingrese '0000'")
                    } else if Int(horaIn) ?? 0 > 2400 {
                        print("Hora incorrecta, favor reingrese.")
                        horaIn = ""
                    }
                } while horaIn == ""
                if horaIn == "0000" {
                    return "No se ha ingresado el Vehículo, dado que no se ingresó hora de llegada"
                } else {
                    estacionamiento.ingresarDatos(patente: patenteIn, tipo: tipoVeh, pHoraIn: horaIn)
                    return "Se ha ingresado a las \(horaIn) el vehículo Patente: \(patenteIn) y que es Tipo: \(tipoVeh)"
                }
            }
        } else {
            print("Has salido. No se ha ingresado el Vehículo. Volverás al menú principal")
            return "Volviendo a Menú Principal"
        }
        return ""
    }
    
    func retirarVehiculo() {
        var pOut: String = ""
        var hSal: String = ""
        var mont: String = ""
        var inDescuento: String = ""
        repeat {
            print("Ingrese patente de vehículo a retirar:")
            pOut = readLine() ?? ""
            if pOut == "" {
                print("Por favor ingrese un valor. Si desea salir escriba '0'")
            } else if pOut == "0" {
                return
            }
        } while pOut == ""
        
        repeat {
            print("Ingrese hora de Salida: ")
            hSal = readLine() ?? ""
            if hSal == "" {
                print("Por favor ingrese un valor. Si desea salir escriba '0'")
            } else if hSal == "0" {
                print("Ha decicido no ingresar hora de Salida. No se ha retirado el vehículo")
                return
            } else if Int(hSal) ?? 0 > 2400 {
                print("Hora incorrecta. Favor reingrese.")
                hSal = ""
            }
        } while hSal == ""
       
        repeat {
            print("¿Desea aplicar una tarjeta de descuento?")
            print("""
                  Ingrese la opción:
                  Opción [1]: Si
                  Opción [2]: No
                  """)
            inDescuento = readLine() ?? ""
            if inDescuento == "" {
                print("Favor ingrese una opción válida. Si desea salir ingrese 0, en ese caso no se aplicará descuento")
            } 
        } while inDescuento == ""
        mont = estacionamiento.calcularMonto(placa: pOut, hOut: hSal, discount: inDescuento)
        if mont == "" {
            print("No se ha podido retirar el vehículo")
        } else {
            estacionamiento.sacarVehiculo(patenteOut: pOut.uppercased(), horaSal: hSal, monto: mont)
        }
       
    }
    
    func verRecaudacion() {
        estacionamiento.verRecaudacion()
    }
    
    func verificarDisponibilidad() -> Bool{
        var disponible: Bool
        disponible = estacionamiento.disponibilidad()
        return disponible
    }
    
    func contarDisponibles() -> Int{
        return (estacionamiento.contarEspacios())
    }
}
