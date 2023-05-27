//
//  CarritoViewModel.swift
//  JarroyoEcomerceVenta
//
//  Created by MacBookMBP1 on 26/05/23.
//

import Foundation
import UIKit
import CoreData

class CarritoViewModel{
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func Add(_ IdProducto : Int) -> Result{
        var result = Result()
        
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "VentaProducto", in: context)!
        
        let producto = NSManagedObject(entity: entity, insertInto: context)
        
        producto.setValue(IdProducto, forKey: "idProducto")
        producto.setValue(1, forKey: "cantidad")
        
        do{
            try context.save()
            result.Correct = true
        }
        catch let error {
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            result.Ex = error
        }
        
        return result
    }
//    func Update(IdProducto : Int){
//        let context = appDelegate.persistentContainer.viewContext
//        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "VentaProducto")
//        fetchRequest.predicate = NSPredicate(format: "name = %@", CarritoCell.self as! CVarArg)
//        do{
//            let value = try  context.fetch(fetchRequest)
//            let valueUpdate = value[index] as! NSManagedObject
//            valueUpdate.setValue(name, forKeyPath: "name")
//            do{
//                try context.save()
//            } catch{
//                print(error)
//            }
//        }catch{
//            print(error)
//            
//        }
//    }
//    func Delete(IdProducto : Int){
//        let context = appDelegate.persistentContainer.viewContext
//        context.delete(IdProducto[indexPath.row])
//        //context.delete(people[indexPath.row])
//        do {
//            try  context.save()
//            people.remove(at: indexPath.row)
//            tableViewOutlet.deleteRows(at: [indexPath], with: .fade)
//            } catch {
//                let saveError = error as NSError
//                print(saveError)
//                
//            }
//    }
    func GetById(IdProducto : Int){
        
    }
    func GetAll() -> Result{
        var result = Result()
        let context = appDelegate.persistentContainer.viewContext
        let response = NSFetchRequest<NSFetchRequestResult> (entityName: "VentaProducto")
        
        do{
            let resultFetch = try context.fetch(response)
            for obj in resultFetch as! [NSManagedObject]{
                let ventaProducto = VentaProducto()
                
                ventaProducto.producto?.IdProducto = obj.value(forKey: "idProducto") as! Int
                ventaProducto.cantidad = obj.value(forKey: "cantidad") as! Int
                
                let resultById = ProductoViewModel.GetById(IdProducto: ventaProducto.producto?.IdProducto as! Int)
                
                if resultById.Correct! {
                    let producto = result.Object! as! Producto
                }
                
                let idVentaProducto = obj.value(forKey: "idProducto")
                let cantidad = obj.value(forKey: "cantidad")
                print(idVentaProducto)
                let result = ProductoViewModel.GetById(IdProducto: idVentaProducto as! Int)
                print(cantidad)
            }
        }
        catch let error {
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            result.Ex = error
        }
        
        return result
    }
}
