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
    
    func Updates(IdProducto : Int, cantidad : Int) -> Result{
        var result = Result()
        var ventaProd = VentaProductos()
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "VentaProducto")
        
        fetchRequest.predicate = NSPredicate(format: "idProducto = \(IdProducto)")
        
        do{
            let pract = try  context.fetch(fetchRequest)
            let upd = pract[0] as! NSManagedObject
            upd.setValue(cantidad, forKey: "cantidad")
            do{
                try context.save()
                result.Correct = true
            } catch let error {
                result.Correct = false
                result.ErrorMessage = error.localizedDescription
                result.Ex = error
            }
        }
        catch let error {
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            result.Ex = error
        }
        return result
    }
    
    func Delete(IdProducto : Int) -> Result{
        var result = Result()
        let context = appDelegate.persistentContainer.viewContext
        //let response = NSFetchRequest<NSFetchRequestResult>(entityName: "VentaProducto")
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "VentaProducto")
        fetchRequest.predicate = NSPredicate.init(format: "idProducto==\(IdProducto)")
        let objects = try! context.fetch(fetchRequest)
        //context.delete(object)
        for obj in objects {
            context.delete(obj as! NSManagedObject)
        }
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
    
    func GetById(IdProducto : Int) -> Result{
        var result = Result()
        let context = appDelegate.persistentContainer.viewContext
        let response = NSFetchRequest<NSFetchRequestResult>(entityName: "VentaProducto")
        //let predicate = NSPredicate(format: "idProducto = %i", IdProducto)
       
        response.predicate = NSPredicate(format: "idProdcuto = \(IdProducto)")
        
        do{
            result.Object = []
            let resolve = try context.fetch(response)
            for obj in resolve as! [NSManagedObject]{
                let modelVp = VentaProductos()
                
                modelVp.producto = Producto()
                
                modelVp.producto?.IdProducto = obj.value(forKey: "idProducto") as! Int
                modelVp.cantidad = obj.value(forKey: "cantidad") as! Int
                
                let resultId = ProductoViewModel.GetById(IdProducto: modelVp.producto?.IdProducto as! Int)
                if resultId.Correct! {
                    let produc = resultId.Object! as! Producto
                    
                    modelVp.producto?.Nombre = produc.Nombre
                    modelVp.producto?.Imagen = produc.Imagen
                }
                result.Object = modelVp
            }
            result.Correct = true
            //try context.save()
        }
        catch let error{
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            result.Ex = error
            print(error.localizedDescription)
        }
        return result
    }

    func GetAll() -> Result{
        var result = Result()
        result.Correct = true
        let context = appDelegate.persistentContainer.viewContext
        let response = NSFetchRequest<NSFetchRequestResult> (entityName: "VentaProducto")
        do{
            result.Objects = []
            let resultFetch = try context.fetch(response)
            for obj in resultFetch as! [NSManagedObject]{
                let ventaProducto = VentaProductos()
                ventaProducto.producto = Producto()
                ventaProducto.producto?.IdProducto = obj.value(forKey: "idProducto") as! Int
                ventaProducto.cantidad = obj.value(forKey: "cantidad") as! Int
                let resultGetById = ProductoViewModel.GetById(IdProducto:ventaProducto.producto?.IdProducto as! Int)
                if resultGetById.Correct! {
                    let produ = resultGetById.Object! as! Producto
                    ventaProducto.producto?.Nombre = produ.Nombre
                    ventaProducto.producto?.Imagen = produ.Imagen
                    ventaProducto.producto?.PrecioUnitario = produ.PrecioUnitario
                }
                result.Objects?.append(ventaProducto)
            }
            result.Correct = true
        }
        catch let error {
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            result.Ex = error
        }
        return result
    }
    
}
