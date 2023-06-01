//
//  CarritoController.swift
//  JarroyoEcomerceVenta
//
//  Created by MacBookMBP1 on 26/05/23.
//

import UIKit
import SwipeCellKit

class CarritoController: UITableViewController {
    
    var productoVenta : [VentaProductos] = []
    var productosA : [Producto] = []
    var IdProducto : Int = 0
    var total : Double = 0
    var subto : Int = 0
    var carritoViewModel = CarritoViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
        tableView.reloadData()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CarritoCell", bundle: .main), forCellReuseIdentifier: "CarritoCell")
        updateUI()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productoVenta.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarritoCell", for: indexPath) as! CarritoCell
        cell.delegate = self
        cell.lblNombre.text = productoVenta[indexPath.row].producto?.Nombre
        cell.lblCantidad.text = ("Cantidad: \(String(productoVenta[indexPath.row].cantidad!))")
        cell.lblPrecio.text = ("$ \(String(describing: productoVenta[indexPath.row].producto?.PrecioUnitario!))")
        
        subto = productoVenta[indexPath.row].cantidad! * (productoVenta[indexPath.row].producto?.PrecioUnitario ?? 0)
        //let subtotal = Double(productoVenta[indexPath.row].cantidad!) * Double((productoVenta[indexPath.row].producto?.PrecioUnitario)!)
        //total += subtotal
        cell.lblPrecio.text = String(subto)

        if productoVenta[indexPath.row].producto?.Imagen == "img" || productoVenta[indexPath.row].producto?.Imagen == nil || productoVenta[indexPath.row].producto?.Imagen == ""  {
            cell.Imagen.image = UIImage(named: "AppIcon")
        }else{
            let string =  productoVenta[indexPath.row].producto?.Imagen
            let newImageData = Data(base64Encoded: string!)
            if let newImageData = newImageData {
                cell.Imagen.image = UIImage(data: newImageData)
            }
        }
        cell.step.value = Double(productoVenta[indexPath.row].cantidad!)
        cell.step.tag = indexPath.row
        cell.step.addTarget(self, action: #selector(StepAction), for: .touchUpInside)
        return cell
    }
    
    @objc func StepAction(sender: UIStepper){
        let indexPath = IndexPath(row: sender.tag,section: 0)
        //let indexPath = productoVenta[sender.tag].cantidad
        print("Sender = \(sender.value)")
        if sender.value >= 1 {
            if carritoViewModel.Updates(IdProducto: (productoVenta[indexPath.row].producto?.IdProducto)!, cantidad: Int(sender.value)).Correct!{
                total = 0.0
                updateUI()
                print("Actulizado")
            }else {
                print("No se actualizao")
            }
        } else {
            sender.value = 1
            print("No se realizo nada")
        }
        
    }
    
    func updateUI(){
        var result = carritoViewModel.GetAll()
        productoVenta.removeAll()
        if result.Correct! {
            for objUsuario in result.Objects!{
                let prod = objUsuario as! VentaProductos //Unboxing
                productoVenta.append(prod)
            }
            tableView.reloadData()
        }
    }
    
//    func loadData(){
//        let result = carritoViewModel.GetAll()
//        if result.Correct! {
//            for prodac in result.Objects!{
//                let prodNu = prodac as! VentaProducto
//                self.tableView.reloadData()
//                DispatchQueue.main.async{
//                    print("El total es de: \(self.total)")
//                    //self.totallabel.text = "$ \(String(self.total))"
//                }
//            }
//        }
//    }
    
}

extension CarritoController : SwipeTableViewCellDelegate{

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        if orientation == .right{
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                let result = self.carritoViewModel.Delete(IdProducto: (self.productoVenta[indexPath.row].producto?.IdProducto!)!)
                if result.Correct!{
                    print("Producto eliminado")
                    let alert = UIAlertController(title: "Mensaje", message: "Producto eliminado del carrito correctamente", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Aceptar", style: .default)
                    alert.addAction(action)
                    self.present(alert, animated: true)
                    self.updateUI()
                }else  {
                    print("Ocurrio un error")
                }
            }
            return [deleteAction]
        }
        return nil
    }
}
