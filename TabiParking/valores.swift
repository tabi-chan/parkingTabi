//
//  valores.swift
//  TabiParking
//
//  Created by Tabata Céspedes Figueroa on 28-03-23.
//

import Foundation
enum tipoVehi:String {
    case Auto
    case Moto
    case Minibus
    case Bus
    case Otro
    
    // QUITAR UNA LINEA DE ESPACIO
    var valorXtipo: Int{
        switch self {
            case .Auto: return 20
            case .Moto: return 15
            case .Minibus: return 25
            case .Bus: return 30
            case .Otro: return 0
        }
    }
}

