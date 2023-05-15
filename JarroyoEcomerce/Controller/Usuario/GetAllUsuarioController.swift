//
//  GetAllUsuarioController.swift
//  JarroyoEcomerce
//
//  Created by MacBookMBP1 on 03/05/23.
//
import Foundation
import UIKit
import SwipeCellKit

class GetAllUsuarioController: UITableViewController {

    var usuarios : [Usuario] = []
    let dbManager = DBManger()
    var IdUsuario : Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "UsuarioCell", bundle: .main), forCellReuseIdentifier: "UsuarioCell")
        updateUI()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usuarios.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // let cell = tableView.dequeueReusableCell(withIdentifier: "usuarioCell", for: indexPath) as! UsuarioCell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsuarioCell", for: indexPath) as! UsuarioCell
        cell.delegate = self
        cell.txtNombre.text = "\(usuarios[indexPath.row].Nombre!) " + "\(usuarios[indexPath.row].ApellidoPaterno!) " + "\(usuarios[indexPath.row].ApellidoMaterno!)"
        cell.txtFecha.text = usuarios[indexPath.row].FechaNacimiento
        cell.txtUsuario.text = usuarios[indexPath.row].UserName
        cell.txtRol.text = usuarios[indexPath.row].Rol?.Nombre
        return cell
    }
}
extension GetAllUsuarioController : SwipeTableViewCellDelegate{
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        if orientation == .right{
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                //print(indexPath.row) print("Se ejecuto la funcion de borrar")
                let result = UsuarioViewModel.Delete(IdUsuario: self.usuarios[indexPath.row].IdUsuario!)
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
                self.IdUsuario = self.usuarios[indexPath.row].IdUsuario!
                self.performSegue(withIdentifier: "ViewController", sender: self)
            }
            return [updateAction]
        }
        return nil
    }
    
    func updateUI(){
        var result = UsuarioViewModel.GetAll()
        usuarios.removeAll()
        if result.Correct!{
            for objusuario in result.Objects!{
            let usuario = objusuario as! Usuario //Unboxing
            usuarios.append(usuario)
           }
       tableView.reloadData()
     }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ViewController"{
            var formControl = segue.destination as! ViewController
            formControl.IdUsuario = self.IdUsuario
            print(IdUsuario)
        }
        
    }
}


