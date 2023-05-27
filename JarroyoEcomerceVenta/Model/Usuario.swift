//
//  Usuario.swift
//  JarroyoEcomerce
//
//  Created by MacBookMBP1 on 28/04/23.
//
import SQLite3
import Foundation

class Usuario {
    
    var IdUsuario : Int? = nil
    var Nombre : String? = nil
    var ApellidoPaterno : String? = nil
    var ApellidoMaterno : String? = nil
    var FechaNacimiento : String? = nil
    var UserName : String? = nil
    var Password : String? = nil
    var Rol : Rol? = nil
}

