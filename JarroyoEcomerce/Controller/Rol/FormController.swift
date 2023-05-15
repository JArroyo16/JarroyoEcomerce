//
//  FormController.swift
//  JarroyoEcomerce
//
//  Created by MacBookMBP1 on 09/05/23.
//

import UIKit

class FormController: UIViewController {

    @IBOutlet weak var txtIdRol: UITextField!
    
    @IBOutlet weak var txtNombre: UITextField!
    
    
    @IBOutlet weak var btnAction: UIButton!
    
    let dbManager = DBManger()
    var IdRol : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtIdRol.isEnabled = false
        self.txtNombre.delegate = self
        // Do any additional setup after loading the view.
    
        if IdRol == 0 {
            var rol = Rol()
            self.txtIdRol.text = ""
            self.txtNombre.text = ""
            
            btnAction.backgroundColor = .green
            btnAction.setTitle("Agregar", for: .normal)
        } else {
            let datos = RolViewModel.GetById(IdRol: IdRol)
            let rol = datos.Object as! Rol
            self.txtIdRol.text = rol.IdRol?.description
            self.txtNombre.text = rol.Nombre
            
            btnAction.backgroundColor = .orange
            btnAction.setTitle("Actualizar", for: .normal)
        }
        
    }
    
    @IBAction func btnAction(_ sender: Any) {
        
        let opcion = btnAction.titleLabel?.text
        switch opcion{
        case "Agregar":
            var rol = Rol()
            
            rol.Nombre = txtNombre.text!
            
            let result = RolViewModel.Add(rol: rol)
            if result.Correct!{
                let alert = UIAlertController(title: "Aceptar", message: "Rol agregado correctamente", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)
                alert.addAction(action)
                present(alert, animated: true)
            } else {
                let alert = UIAlertController(title: "Mensaje", message: "Por favor llena los campos", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)
                alert.addAction(action)
                present(alert, animated: true)
            }
            break
        case "Actualizar":
            var rol = Rol()
            
            rol.IdRol = Int(txtIdRol.text!) ?? 0
            rol.Nombre = txtNombre.text!
            
            let result = RolViewModel.Update(rol: rol)
            if result.Correct! {
                let alert = UIAlertController(title: "Mensaje", message: "Rol actualizado correctamente", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)
                alert.addAction(action)
                present(alert, animated: true)
            } else {
                let alert = UIAlertController(title: "Mensaje", message: "Por favor lena todos los campos", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)
                alert.addAction(action)
                present(alert, animated: true)
            }
            break
        default:
            print("No se realizo nada")
        }
        
    }
}

extension FormController : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtNombre.resignFirstResponder()
    }
    
}
