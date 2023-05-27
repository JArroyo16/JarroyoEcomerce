//
//  ProductoController.swift
//  JarroyoEcomerce
//
//  Created by MacBookMBP1 on 24/05/23.
//

import UIKit

private let reuseIdentifier = "ProductoCollectionCell"

class ProductoController: UICollectionViewController {

    var producto : [Producto] = []
    let dbManager = DBManger()
    var IdDepartamento = 0
    var nombreProducto = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        collectionView.register(UINib(nibName: "ProductoCollectionCell", bundle: .main), forCellWithReuseIdentifier: "ProductoCollectionCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        //updateUI()
        
        if IdDepartamento == 0 {
            var result = ProductoViewModel.GetByNombre(Nombre: nombreProducto)
            producto.removeAll()
            if result.Correct!{
                for objR in result.Objects!{
                let objrol = objR as! Producto //Unboxing
                producto.append(objrol)
               }
           collectionView.reloadData()
         }
        } else {
            var result = ProductoViewModel.GetByIdDep(IdDepartamento: IdDepartamento)
            producto.removeAll()
            if result.Correct!{
                for objR in result.Objects!{
                let objrol = objR as! Producto //Unboxing
                producto.append(objrol)
               }
           collectionView.reloadData()
         }
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return producto.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductoCollectionCell", for: indexPath) as! ProductoCollectionCell
        
        cell.lblNombre.text = producto[indexPath.row].Nombre
        cell.lblDescripcion.text = producto[indexPath.row].Descripcion
        cell.lblPrecio.text = producto[indexPath.row].PrecioUnitario?.description
        //cell.Imagen.image = producto[indexPath.row].Imagen
        if producto[indexPath.row].Imagen == "img" || producto[indexPath.row].Imagen == nil || producto[indexPath.row].Imagen == ""  {
                    cell.Imagen.image = UIImage(named: "AppIcon")
                }else{
                    let string =  producto[indexPath.row].Imagen
                        let newImageData = Data(base64Encoded: string!)
                        if let newImageData = newImageData {
                        cell.Imagen.image = UIImage(data: newImageData)
                        }
                }
        
        return cell
    }
    
    
//    func updateUI(){
//
//        var result = ProductoViewModel.GetByIdDep(IdDepartamento: IdDepartamento)
//
//        producto.removeAll()
//        if result.Correct!{
//            for objR in result.Objects!{
//            let objrol = objR as! Producto //Unboxing
//            producto.append(objrol)
//           }
//       collectionView.reloadData()
//     }
//    }
}
