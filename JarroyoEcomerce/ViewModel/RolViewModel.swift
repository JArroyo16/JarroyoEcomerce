//
//  RolViewModel.swift
//  JarroyoEcomerce
//
//  Created by MacBookMBP1 on 09/05/23.
//
import SQLite3
import Foundation

class RolViewModel{
    
    static func Add(rol: Rol) -> Result{
        var context = DBManger()
        var result = Result()
        var statement : OpaquePointer? = nil
        var query = "INSERT INTO Rol (Nombre) values (?)"
        do{
            if try (sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK){
                sqlite3_bind_text(statement, 1, (rol.Nombre as! NSString).utf8String, -1, nil)
                
                if (sqlite3_step(statement) == SQLITE_DONE){
                    print("Rol registrado correctamente")
                    result.Correct = true
                }else {
                    print("Error al insertar")
                    result.Correct = false
                    result.ErrorMessage = "Ocurrio un error"
                }
            }
        }
        catch let ex{
            result.Correct = false
            result.ErrorMessage = ex.localizedDescription
            result.Ex = ex
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
    
    static func Update (rol: Rol) -> Result {
        var context = DBManger()
        var result = Result()
        var statement : OpaquePointer?
        var query = "UPDATE Rol SET Nombre = ? WHERE IdRol = \(rol.IdRol!)"
        do{
            if try (sqlite3_prepare(context.db,query, -1, &statement, nil) == SQLITE_OK) {
                sqlite3_bind_text(statement, 1, (rol.Nombre as! NSString).utf8String, -1, nil)
                
                if try (sqlite3_step(statement) == SQLITE_DONE){
                    print("Rol Actualizado correctamente")
                    result.Correct = true
                } else {
                    print("Error al actualiar")
                    result.Correct = false
                    result.ErrorMessage = "Ocurrio un error"
                }
            }
        }
        catch let ex{
            result.Correct = false
            result.ErrorMessage = ex.localizedDescription
            result.Ex = ex
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
    
    static func Delete (IdRol : Int) -> Result {
        var context = DBManger()
        var result = Result()
        var statement : OpaquePointer? = nil
        var query = "DELETE FROM Rol WHERE IdRol = \(IdRol)"
        
        do{
            if try (sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK){
                if try(sqlite3_step(statement) == SQLITE_DONE){
                    print("Rol eliminado correctamente")
                    result.Correct = true //pruebalo  //Que le falta? ?
                } else {
                    print("Error al eliminar rol")
                    result.Correct = false
                    result.ErrorMessage = "Ocurrio un error"
                }
            }
        }
        catch let ex{
            result.Correct = false
            result.ErrorMessage = ex.localizedDescription
            result.Ex = ex
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
    
    static func GetAll() -> Result{
        var context = DBManger()
        var result = Result()
        let query = "SELECT IdRol, Nombre FROM Rol"
        var statement : OpaquePointer?
        
        do{
            if try sqlite3_prepare(context.db, query, -1, &statement, nil) == SQLITE_OK{
                result.Objects = []
                while try sqlite3_step(statement) == SQLITE_ROW {
                    var rol = Rol()
                    rol.IdRol = Int(sqlite3_column_int(statement, 0))
                    rol.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                    
                    result.Objects?.append(rol)
                }
                result.Correct = true
            } else {
                result.Correct = false
                result.ErrorMessage = "Ocurrio un error"
            }
        }
        catch let ex{
            result.Correct = false
            result.ErrorMessage = ex.localizedDescription
            result.Ex = ex
        }
        return result
    }
    
    static func GetById(IdRol: Int) -> Result{
        var context = DBManger()
        var result = Result()
        let query = "Select IdRol, Nombre FROM Rol WHERE IdRol = \(IdRol)"
        var statement : OpaquePointer?
        
        do {
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) ==  SQLITE_OK{
                if try sqlite3_step(statement) == SQLITE_ROW{
                    var rol = Rol()
                    rol.IdRol = Int(sqlite3_column_int(statement, 0))
                    rol.Nombre = String(cString: sqlite3_column_text(statement, 1))
                    
                    result.Object = rol
                }
                result.Correct = true
            } else{
                result.Correct = false
                result.ErrorMessage = "Ocurrio un error"
            }
        }
        catch let ex{
            result.Correct = false
            result.ErrorMessage = ex.localizedDescription
            result.Ex = ex
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
}
