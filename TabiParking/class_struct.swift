//
//  Class.swift
//  TabiParking
//
//  Created by Tabata Céspedes Figueroa on 28-03-23.
//

import Foundation

//Clase
class Vehiculo: Equatable {
    static func == (lhs: Vehiculo, rhs: Vehiculo) -> Bool {
        return lhs.patente == rhs.patente
    }
    
    var patente: String
    var tipo: tipoVehi
    var horaIn: String
    var horaOut: String
    var montoPagado: String
    
    init(patente: String = "", tipo: tipoVehi = .Otro, horaIn: String = "", horaOut: String = "", montoPagado: String = "") {
        self.patente = patente
        self.tipo = tipo
        self.horaIn = horaIn
        self.horaOut = horaOut
        self.montoPagado = montoPagado
    }
}

//Struct
struct Parking {
    var vehiculos: [Vehiculo] = []
    var retirados: [Vehiculo] = []
    
    func visualizarVehiculos() {
        print("|     Patente     | Tipo de Vehículo |    Hora Ingreso ")
        vehiculos.forEach { vehiculo in
            print("\t\t \(vehiculo.patente) \t\t \(vehiculo.tipo) \t\t  \(vehiculo.horaIn)")
        }
    }
    
    mutating func ingresarDatos(patente: String, tipo: tipoVehi, pHoraIn: String) {
        var patenteOK: Bool = false
        var tipoOK: Bool = false
        var horaOK: Bool = false
        var vehi: Vehiculo
        if patente != "" {
            patenteOK = true
        }
        if tipo != .Otro {
            tipoOK = true
        }
        if pHoraIn != "" {
            horaOK = true
        }
        
        if patenteOK && tipoOK && horaOK {
            vehi = Vehiculo(patente: patente, tipo: tipo, horaIn: pHoraIn)
            vehiculos.append(vehi)
        }
    }
    
    mutating func sacarVehiculo(patenteOut: String, horaSal: String, monto: String) {
        var removeOK: Bool = false
        vehiculos.forEach { vehiculo in
            if vehiculo.patente == patenteOut {
                vehiculo.horaOut = horaSal
                vehiculo.montoPagado = monto
                retirados.append(vehiculo)
                let indexV = vehiculos.firstIndex(of: vehiculo)
                guard let indiceDestapado = indexV else {
                    print("No se encontró el indice")
                    return
                }
                vehiculos.remove(at: indiceDestapado)
                removeOK = true
            }
        }
        
        if removeOK {
            print("Salida exitosa del vehículo")
        } else {
            print("No se ha encontrado el vehículo, recurra a la oficina más cercana D:")
        }
    }
    
    func verRecaudacion() {
        var total: Int = 0
        print(" Patente         Tipo   Hora Entrada  Hora Salida  Monto Pagado")
        retirados.forEach { vehiculo in
            print(" \(vehiculo.patente)  \t\t \(vehiculo.tipo) \t\t \(vehiculo.horaIn) \t\t \(vehiculo.horaOut) \t\t \(vehiculo.montoPagado)")
            total = total + (Int(vehiculo.montoPagado) ?? 0)
        }
        print("Total del día: \(total)")
    }
    
    func calcularMonto(placa: String, hOut: String, discount: String) -> String {
        var horIn: String = ""
        var tip: tipoVehi = .Otro
        var flVehiExiste: Bool = false
        var flDescuento: Bool = false
        var tiempoValido: Bool = true
        var tiempoXHoraExtra: Int = 0
        var tiempoEntero: Int
        var tiempoFraccion: Int
        var precio: Int = 0
        var montoXFraccion: Double
        var descuento: Int = 0
        vehiculos.forEach { vehiculo in
            if vehiculo.patente == placa.uppercased() {
                horIn = vehiculo.horaIn
                tip = vehiculo.tipo
                flVehiExiste = true
            }
        }
        if flVehiExiste {
            var tiempoOUTEntero: Int? = Int(hOut.prefix(2))
            var tiempoInEntero: Int? = Int(horIn.prefix(2))
            var tiempoOUTFraccion: Int? = Int(hOut.suffix(2))
            var tiempoInFraccion: Int? = Int(horIn.suffix(2))
            guard let tiempoOutDestapado = tiempoOUTEntero else { return "" }
            guard let tiempoInDestapado = tiempoInEntero else { return "" }
            guard let tiempoFracOutDestapado = tiempoOUTFraccion else { return "" }
            guard let tiempoFracInDestapado = tiempoInFraccion else { return "" }
            
            tiempoEntero = tiempoOutDestapado - tiempoInDestapado
            tiempoFraccion = tiempoFracOutDestapado - tiempoFracInDestapado
            tiempoXHoraExtra = (tiempoEntero - 2)
            if tiempoEntero < 0 {
                tiempoValido = false
                print("La cantidad de tiempo no es válida.")
                return ""
            }
            if discount == "1" {
                flDescuento = true
            }
            switch tiempoEntero{
            case 2...2400 where tiempoFraccion > 0 || tiempoXHoraExtra > 0:
                print("El tiempo es mayor a 2 horas")
                if tiempoXHoraExtra == 0 {
                    tiempoXHoraExtra = 20
                } else {
                    tiempoXHoraExtra = tiempoXHoraExtra * 20
                }
                
                switch tiempoFraccion{
                case 1...15:
                    montoXFraccion = 5
                case 16...30:
                    montoXFraccion = 10
                case 31...45:
                    montoXFraccion = 15
                case 46...60:
                    montoXFraccion = 20
                default:
                    montoXFraccion = 0
                }
                precio = tip.valorXtipo + Int(tiempoXHoraExtra) + Int(montoXFraccion)
            case 0...2 where tiempoValido == true:
                print("El tiempo está en el rango de las primeras 2 horas")
                precio = tip.valorXtipo
            default:
                print("No se ha podido calcular el tiempo, favor revisar")
            }
            if (flDescuento) {
                print("Ha estado estacionado \(tiempoEntero) horas y \(tiempoFraccion) minutos y el Valor es \(precio). Se aplicará tarjeta de descuento.")
                descuento = (precio * 15)/100
                precio = precio - descuento
                print("Se ha aplicado un descuento del 15% equivalente a \(descuento) dolares, el valor final a pagar es \(precio)")
            } else {
                print("Ha estado estacionado \(tiempoEntero) horas y \(tiempoFraccion) minutos y el Valor es \(precio). No se aplicará descuento.")
            }
            return String(precio)
        }
        print("El vehículo no ha sido encontrado.")
        return ""
    }
        
    func disponibilidad() -> Bool {
        let n = vehiculos.count
        if n == 20 {
            return false
        } else {
            return true
        }
    }
        
    func contarEspacios() -> Int {
        return (20 - vehiculos.count)
    }
        
    func verificarVehiculo(patenteValidar: String) -> Bool {
        var flExiste: Bool = false
        vehiculos.forEach { vehi in
            if vehi.patente == patenteValidar{
                flExiste = true
            }
        }
        return flExiste
    }
}
