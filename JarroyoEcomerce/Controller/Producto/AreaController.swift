//
//  AreaController.swift
//  JarroyoEcomerce
//
//  Created by MacBookMBP1 on 23/05/23.
//

import UIKit

class AreaController: UIViewController {
    var area : [Area] = []
    let dbManager = DBManger()
    var IdArea = 0
    var nombreProducto = ""
    
    @IBOutlet weak var ItemArea: UICollectionView!
    
    @IBOutlet weak var txtBusqueda: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        ItemArea.register(UINib(nibName: "AreaCell", bundle: .main), forCellWithReuseIdentifier: "AreaCell")
        ItemArea.delegate = self
        ItemArea.dataSource = self
        updateUI()
    }
    
    @IBAction func btnBusqueda() {
        
        if txtBusqueda.text == "" {
            let alert = UIAlertController(title: "Mensaje", message: "Por favor ingresa el nombre de un producto", preferredStyle: .alert)
            let action = UIAlertAction(title: "Aceptar", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
        }
        nombreProducto = txtBusqueda.text!
        var result = ProductoViewModel.GetByNombre(Nombre: nombreProducto)
        if result.Correct!{
            performSegue(withIdentifier: "Busqueda", sender: self)
        }
    }
    
}

extension AreaController :  UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return area.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "AreaCell", for: indexPath) as! AreaCell
        cell.lblArea.text = area[indexPath.row].Nombre
        if area[indexPath.row].Nombre ==  area[indexPath.row].Nombre {
            cell.Imagen.image = UIImage(named: "\(area[indexPath.row].Nombre!)")
                }else{
    
                }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Se selecciono \(area[indexPath.row].Nombre!)")
        IdArea = area[indexPath.row].IdArea!
        print(IdArea)
        self.performSegue(withIdentifier: "Departamentos", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Departamentos"{
            var formControl = segue.destination as! DepartamentoController
            formControl.IdArea = self.IdArea
            print(IdArea)
        }
        if segue.identifier == "Busqueda"{
            var formControl = segue.destination as! ProductoController
            formControl.nombreProducto = self.nombreProducto
        }
    }
    
    func updateUI(){
        var result = AreaViewModel.GetAll()
        area.removeAll()
        if result.Correct!{
            for objR in result.Objects!{
            let objrol = objR as! Area //Unboxing
            area.append(objrol)
           }
       ItemArea.reloadData()
     }
    }
}
