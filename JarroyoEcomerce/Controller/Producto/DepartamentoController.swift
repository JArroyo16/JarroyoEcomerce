//
//  DepartamentoController.swift
//  JarroyoEcomerce
//
//  Created by MacBookMBP1 on 23/05/23.
//

import UIKit

private let reuseIdentifier = "DepartamentoCell"

class DepartamentoController: UICollectionViewController {

    var departamento : [Departamento] = []
    let dbManager = DBManger()
    var IdArea = 0
    var IdDepartamento = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "DepartamentoCell", bundle: .main), forCellWithReuseIdentifier: "DepartamentoCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        updateUI()
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return departamento.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DepartamentoCell", for: indexPath) as! DepartamentoCell
        cell.lblDepartamento.text = departamento[indexPath.row].Nombre
        if departamento[indexPath.row].Nombre ==  departamento[indexPath.row].Nombre {
            cell.Imagen.image = UIImage(named: "\(departamento[indexPath.row].Nombre!)")
                }else{
                    
                }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Se selecciono \(departamento[indexPath.row].Nombre!)")
        IdDepartamento = departamento[indexPath.row].IdDepartamento!
        print(IdDepartamento)
        self.performSegue(withIdentifier: "Productos", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Productos"{
            //var formControl = segue.destination as! ProductoController
            //formControl.IdDepartamento = self.IdDepartamento
            print(IdDepartamento)
        }
    }
    
    func updateUI(){
        var result = DepartamentoViewModel.GetById(IdArea: IdArea)
        departamento.removeAll()
        if result.Correct!{
            for objR in result.Objects!{
            let objrol = objR as! Departamento //Unboxing
            departamento.append(objrol)
           }
       collectionView.reloadData()
     }
    }
}
