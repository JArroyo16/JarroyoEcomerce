//
//  RegistrpController.swift
//  JarroyoEcomerce
//
//  Created by MacBookMBP1 on 22/05/23.
//
import Firebase
import UIKit

class RegistrpController: UIViewController {

    @IBOutlet weak var txtCorreo: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var txtConfirmarPassword: UITextField!
    
    @IBOutlet weak var btnRegis: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnRegis.isEnabled = false
        
        //btnRegis.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)

    }
    
    func textFieldDidChange(textField: UITextField) {
        if txtCorreo.text!.isEmpty, txtPassword.text!.isEmpty, txtConfirmarPassword.text!.isEmpty{
                btnRegis.isEnabled = false
            }else{
                btnRegis.isEnabled = true
            }
    }
    
    @IBAction func btnRegistrar() {
        guard txtCorreo.text != "" else{
            let alert = UIAlertController(title: "Mensaje", message: "Por favor llena todos los campos solicitados", preferredStyle: .alert)
            let action = UIAlertAction(title: "Aceptar", style: .default)
            alert.addAction(action)
            //alert.showDetailViewController(alert, sender: self)
            present(alert, animated: true)
            return
        }
        
        guard txtPassword.text != "" else{
            let alert = UIAlertController(title: "Mensaje", message: "Por favor llena todos los campos solicitados", preferredStyle: .alert)
            let action = UIAlertAction(title: "Aceptar", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
            return
        }
        guard txtConfirmarPassword.text != "" else{
            let alert = UIAlertController(title: "Mensaje", message: "Por favor llena todos los campos solicitados", preferredStyle: .alert)
            let action = UIAlertAction(title: "Aceptar", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
            return
        }
        
        if txtPassword.text != txtConfirmarPassword.text{
            let alert = UIAlertController(title: "Mensaje", message: "Las contraseñas no coinciden", preferredStyle: .alert)
            let action = UIAlertAction(title: "Aceptar", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
        }
        
        Auth.auth().createUser(withEmail: txtCorreo.text!, password: txtPassword.text!) { authResult, error in
            
            let validarerror = error
            let validarauth = authResult
            
            if let ex = error{
                let alert = UIAlertController(title: "Mensaje", message: "Correo y/o contraseña incorrecta", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true)
            }
            if let correcto = authResult{
                self.performSegue(withIdentifier: "TabBar", sender: self)
            }
        }
    }
}
