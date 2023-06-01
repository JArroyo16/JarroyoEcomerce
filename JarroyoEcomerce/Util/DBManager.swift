//
//  DBManager.swift
//  JarroyoEcomerce
//
//  Created by MacBookMBP1 on 28/04/23.
//
import SQLite3
import Foundation

class DBManger{
    
    var db : OpaquePointer?  //0x0000000
    let path : String = "Document.JarroyoEcomerce.sqlite"
    
    init(){
        self.db = Get()
    }
    
    func Get() -> OpaquePointer?{
        let filePathCompartido = try! FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.JarroyoEcomerce")!
            .appendingPathComponent(path)
        print(filePathCompartido)
        let filePath = try! FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(path)
        if(sqlite3_open(filePathCompartido.path, &db) == SQLITE_OK){
            print("Conexion exitosa")
            print(filePath)
            return db
        }else{
            print("Fallo la conexión")
            return nil
        }
    }
    //           func Get() -> OpaquePointer?{
    //               let filePath = try! FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(path)
    //               if(sqlite3_open(filePath.path, &db) == SQLITE_OK){
    //                   print("Conexion exitosa")
    //                   print(filePath)
    //                   return db
    //               }else{
    //                   print("Fallo la conexión")
    //                   return nil
    //               }
    //           }
    //       }
    //}
}
