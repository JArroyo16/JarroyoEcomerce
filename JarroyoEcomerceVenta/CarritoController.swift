//
//  CarritoController.swift
//  JarroyoEcomerceVenta
//
//  Created by MacBookMBP1 on 26/05/23.
//

import UIKit

class CarritoController: UITableViewController {
    
    var producto : [Producto] = []
    var IdProducto : Int = 0

    override func viewWillAppear(_ animated: Bool) {
        updateUI()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CarritoCell", bundle: .main), forCellReuseIdentifier: "CarritoCell")
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return producto.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarritoCell", for: indexPath) as! CarritoCell
        //cell.delegate = self
        cell.lblNombre.text = producto[indexPath.row].Nombre
        //cell.lblCantidad[indexPath.row]
        cell.lblCantidad.text = producto[indexPath.row].Stock?.description
        return cell
    }
    
    func updateUI(){
        var result = ProductoViewModel.GetAll()
        producto.removeAll()
        if result.Correct!{
            for obj in result.Objects!{
            let productos = obj as! Producto
            producto.append(productos)
           }
       tableView.reloadData()
     }
    }
}
