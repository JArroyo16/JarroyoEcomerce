//
//  LoginController.swift
//  JarroyoEcomerce
//
//  Created by MacBookMBP1 on 22/05/23.
//
//import FirebaseCore
import Firebase
import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var txtCorreo: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func btbIngresar() {
        
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
                
        Auth.auth().signIn(withEmail: txtCorreo.text!, password: txtPassword.text!) { [weak self] authResult, error in
        guard let strongSelf = self else { return }
            let validarerror = error
            let validarauth = authResult
            
            if let ex = error{
                let alert = UIAlertController(title: "Mensaje", message: "Correo y/o contraseña incorrecta", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)
                alert.addAction(action)
                self?.present(alert, animated: true)
            }
            if let correcto = authResult{
                self?.performSegue(withIdentifier: "TabBar", sender: self)
            }
        }
    }
    
    @IBAction func btnRegistrar() {
        self.performSegue(withIdentifier: "Registrar", sender: self)
    }
}
