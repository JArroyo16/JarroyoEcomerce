//
//  DepartamentoViewModel.swift
//  JarroyoEcomerce
//
//  Created by MacBookMBP1 on 23/05/23.
//
import SQLite3
import Foundation

class DepartamentoViewModel{
    static func GetAll () -> Result{
        var context = DBManger()
        var result = Result()
        let query = "select IdDepartamento, Nombre, IdArea from Departamento"
        var statement : OpaquePointer?
        
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                result.Objects = []
                while try sqlite3_step(statement) == SQLITE_ROW{
                    var departamento = Departamento()
                    departamento.IdDepartamento = Int(sqlite3_column_int(statement, 0))
                    departamento.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
//                    departamento.Area = Area()
//                    departamento.Area?.IdArea = Int(sqlite3_column_int(statement, 2))
                   // departamento.Area?.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 3)))
                    
                    result.Objects?.append(departamento)
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
    
    static func GetById(IdArea : Int) -> Result{
        var context = DBManger()
        var result = Result()
        let query = "SELECT IdDepartamento, Departamento.Nombre FROM Departamento WHERE Departamento.IdArea = \(IdArea)"
        var statement : OpaquePointer?
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                result.Objects = []
                if try sqlite3_step(statement) == SQLITE_ROW{
                var departamento = Departamento()
                departamento.IdDepartamento = Int(sqlite3_column_int(statement,0))
                departamento.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
//                departamento.Area = Area()
//                departamento.Area?.IdArea = Int(sqlite3_column_int(statement,2))
//                departamento.Area?.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 3)))
                
                //result.Object = departamento
                    result.Objects?.append(departamento)
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
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
}
