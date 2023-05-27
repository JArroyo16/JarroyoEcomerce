//
//  GetAllProductoController.swift
//  JarroyoEcomerce
//
//  Created by MacBookMBP1 on 16/05/23.
//
import Foundation
import SwipeCellKit
import UIKit

class GetAllProductoController: UITableViewController {
    
    var productos : [Producto] = []
    let dbManager = DBManger()
    var IdProducto : Int = 0

    override func viewWillAppear(_ animated: Bool) {
        updateUI()
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ProductoCell", bundle: .main), forCellReuseIdentifier: "ProductoCell")
        updateUI()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return productos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductoCell", for: indexPath) as! ProductoCell
        cell.delegate = self
        cell.lblNombre.text = productos[indexPath.row].Nombre
        //cell.ImageView =
        cell.lblPrecio.text = productos[indexPath.row].PrecioUnitario?.description
        cell.lblDepartamento.text = productos[indexPath.row].Departamento?.Nombre
        cell.lblDescrpcion.text = productos[indexPath.row].Descripcion
        
        if productos[indexPath.row].Imagen == "img" || productos[indexPath.row].Imagen == nil || productos[indexPath.row].Imagen == ""  {
                    cell.ImageView.image = UIImage(named: "AppIcon")
                }else{
                    let string =  productos[indexPath.row].Imagen
                        let newImageData = Data(base64Encoded: string!)
                        if let newImageData = newImageData {
                        cell.ImageView.image = UIImage(data: newImageData)
                        }
                }
        
        return cell
    }
}

extension GetAllProductoController : SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        if orientation == .right{
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                let result = ProductoViewModel.Delete(IdProducto: self.productos[indexPath.row].IdProducto!)
                if result.Correct!{
                    print("Producto eliminado")
                    self.updateUI()
                }else  {
                    print("Ocurrio un error")
                }
            }
            return [deleteAction]
        }
        
        if orientation == .left {
            let updateAction = SwipeAction(style: .default, title: "Update") { action, indexPath in
                //print("Se ejecuto la funcion de update")
                self.IdProducto = self.productos[indexPath.row].IdProducto!
                self.performSegue(withIdentifier: "FormProductoController", sender: self)
            }
            return [updateAction]
        }
        return nil
    }
    
    func updateUI(){
        var result = ProductoViewModel.GetAll()
        productos.removeAll()
        if result.Correct!{
            for objproducto in result.Objects!{
            let produ = objproducto as! Producto //Unboxing
            productos.append(produ)
           }
       tableView.reloadData()
     }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "FormProductoController"{
            var formControl = segue.destination as! FormProductoController
            formControl.IdProducto = self.IdProducto
            print(IdProducto)
        }
        
    }
}

