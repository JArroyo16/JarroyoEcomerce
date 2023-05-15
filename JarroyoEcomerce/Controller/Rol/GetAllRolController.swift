//
//  GetAllRolController.swift
//  JarroyoEcomerce
//
//  Created by MacBookMBP1 on 10/05/23.
//
import Foundation
import SwipeCellKit
import UIKit

class GetAllRolController: UIViewController {
    var roles : [Rol] = []
        let dbManager = DBManger()
        var IdRol : Int = 0

    @IBOutlet weak var RolTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
         updateUI()
        RolTableView.reloadData()
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RolTableView.register(UINib(nibName: "RolCell", bundle: .main), forCellReuseIdentifier: "RolCell")
        RolTableView.delegate = self
        RolTableView.dataSource = self
        updateUI()
        
    }
}

extension GetAllRolController : UITableViewDataSource, UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return roles.count
        }
        
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RolCell", for: indexPath) as! RolCell
        cell.delegate = self
        cell.lblId.text = roles[indexPath.row].IdRol?.description
        cell.lblRol.text = roles[indexPath.row].Nombre
        return cell
    }
}

extension GetAllRolController : SwipeTableViewCellDelegate{
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        if orientation == .right{
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                //print(indexPath.row) print("Se ejecuto la funcion de borrar")
                let result = RolViewModel.Delete(IdRol: self.roles[indexPath.row].IdRol!)
                if result.Correct!{
                    print("Usuario eliminado")
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
                self.IdRol = self.roles[indexPath.row].IdRol!
                self.performSegue(withIdentifier: "FormController", sender: self)
            }
            return [updateAction]
        }
        return nil
    }
    
    func updateUI(){
        var result = RolViewModel.GetAll()
        roles.removeAll()
        if result.Correct!{
            for objR in result.Objects!{
            let objrol = objR as! Rol //Unboxing
            roles.append(objrol)
           }
       RolTableView.reloadData()
     }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "FormController"{
            var formControl = segue.destination as! FormController
            formControl.IdRol = self.IdRol
            print(IdRol)
        }

    }
}
