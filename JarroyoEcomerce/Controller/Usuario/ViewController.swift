//
//  ViewController.swift
//  JarroyoEcomerce
//
//  Created by MacBookMBP1 on 28/04/23.
//

import UIKit
import SwipeCellKit
import iOSDropDown

class ViewController: UIViewController {

    
    @IBOutlet weak var txtActualizarEliminar: UITextField!
    
    @IBOutlet weak var txtNombre: UITextField!
    
    @IBOutlet weak var txtApellidoPaterno: UITextField!
    @IBOutlet weak var txtApellidoMaterno: UITextField!
    //@IBOutlet weak var PickerFecha: UIDatePicker!
    @IBOutlet weak var txtFechaNacimiento: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!

    
    @IBOutlet weak var btnAction: UIButton!
    
    @IBOutlet weak var lblNombre: UILabel!
    
    @IBOutlet weak var lblApellidoPaterno: UILabel!
    
    @IBOutlet weak var lblApellidoMaterno: UILabel!
    
    @IBOutlet weak var lblFechaNacimiento: UILabel!
    
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var lblPassword: UILabel!
    
    @IBOutlet weak var ddlRol: DropDown!
    
    let dbManager = DBManger()
    
    var IdUsuario : Int = 0
    
    var IdRol : Int = 0
    
//    override func viewWillAppear(_ animated: Bool) {
//        self.txtActualizarEliminar.text = ""
//        self.txtNombre.text = ""
//        self.txtApellidoPaterno.text = ""
//        self.txtApellidoMaterno.text = ""
//        self.txtFechaNacimiento.text = ""
//        self.txtUserName.text = ""
//        self.txtPassword.text = ""
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         //Do any additional setup after loading the view.
        //Usuario.GetAll(DbManager : dbManager)
        txtActualizarEliminar.isEnabled = false
        
        ddlRol.didSelect{selectedText , index ,id in
        self.IdRol = id
          }
        
        ddlRol.optionArray = []
        ddlRol.optionIds = []
        let resultRol = RolViewModel.GetAll()
        if resultRol.Correct!{
            for objrol in resultRol.Objects!{
                let rol = objrol as! Rol
                
            ddlRol.optionArray.append(rol.Nombre!)
            ddlRol.optionIds?.append(rol.IdRol!)

            }
        }
        
        if IdUsuario == 0{
            var usuario = Usuario()

            self.txtActualizarEliminar.text = ""
            self.txtNombre.text = ""
            self.txtApellidoPaterno.text = ""
            self.txtApellidoMaterno.text = ""
            self.txtFechaNacimiento.text = ""
            self.txtUserName.text = ""
            self.txtPassword.text = ""
            
            
            btnAction.backgroundColor = .green
            btnAction.setTitle("Agregar", for: .normal)

        }else {

            let datos = UsuarioViewModel.GetById(IdUsuario: IdUsuario)

            let user = datos.Object as! Usuario

            self.txtActualizarEliminar.text = user.IdUsuario?.description
            self.txtNombre.text = user.Nombre
            self.txtApellidoPaterno.text = user.ApellidoPaterno
            self.txtApellidoMaterno.text = user.ApellidoMaterno
            self.txtFechaNacimiento.text = user.FechaNacimiento
            self.txtUserName.text = user.UserName
            self.txtPassword.text = user.Password
            user.Rol = Rol()
            //user.Rol?.IdRol = self.IdRol
            
            
            
            btnAction.backgroundColor = .orange
            btnAction.setTitle("Actualizar", for: .normal)
        }
    }
    
    func Validacion(){
        guard txtNombre.text != "" else {
                   lblNombre.text =  "El campo no puede ser vacio"
                   return
        }
               
        guard txtApellidoPaterno.text != "" else{
                   //fatalError("El ApellidoPaterno es nulo")
                   lblApellidoPaterno.text = "El campo no puede ser vacio"
                   return
        }
        guard txtApellidoMaterno.text != "" else{
                   lblApellidoMaterno.text = "El campo no puede ser vacio"
                   return
        }
        guard txtFechaNacimiento.text != "" else{
                   lblFechaNacimiento.text = "El campo no puede ser vacio"
                   return
        }
        guard txtUserName.text != "" else{
                   lblUserName.text = "El campo no puede ser vacio"
                   return
        }
        guard txtPassword.text != "" else{
                   lblPassword.text = "El campo no puede ser vacio"
                   return
        }
    }
    @IBAction func btnEnviar() {
//        print("Nombre del usuario: \(txtNombre.text!)")
//        print("Apellido paterno del usuario: \(txtApellidoPaterno.text!)")
//        print("Apellido materno del usuario: \(txtApellidoMaterno.text!)")
//        print("Fecha de nacimiento del usuario: \(PickerFecha.date)")
//        print("Nombre de usuario: \(txtUserName.text!)")
//        print("Contraseña del usuario: \(txtPassword.text!)")
        
//        var usuario = Usuario()
//        usuario.Nombre = txtNombre.text!
//        usuario.ApellidoPaterno = txtApellidoPaterno.text!
//        usuario.ApellidoMaterno = txtApellidoMaterno.text!
//        usuario.FechaNacimiento = txtFechaNacimiento.text!
//        usuario.UserName = txtUserName.text!
//        usuario.Password = txtPassword.text!
//        UsuarioViewModel.Add(usuario: usuario)
        
    
               let opcion = btnAction.titleLabel?.text
               switch opcion{
               case "Agregar":
                   var usuario = Usuario()
                   
                   usuario.Nombre = txtNombre.text!
                   usuario.ApellidoPaterno = txtApellidoPaterno.text!
                   usuario.ApellidoMaterno = txtApellidoMaterno.text!
                   usuario.FechaNacimiento = txtFechaNacimiento.text!
                   usuario.UserName = txtUserName.text!
                   usuario.Password = txtPassword.text!
                   usuario.Rol = Rol()
                   usuario.Rol?.IdRol = self.IdRol
                   
                
                   Validacion()
                   let result = UsuarioViewModel.Add(usuario: usuario)
                   if result.Correct! {
                       let alert = UIAlertController(title: "Mensaje", message: "Usuario Agregado correctamente", preferredStyle: .alert)
                       let action = UIAlertAction(title: "Aceptar", style: .default)
                       alert.addAction(action)
                       //alert.showDetailViewController(alert, sender: self)
                       present(alert, animated: true)
                   }else{
                       let alert = UIAlertController(title: "Mensaje", message: "Por favor llena todos los campos solicitados", preferredStyle: .alert)
                       let action = UIAlertAction(title: "Aceptar", style: .default)
                       alert.addAction(action)
                       //alert.showDetailViewController(alert, sender: self)
                       present(alert, animated: true)
                   }
                   break
               case "Actualizar":
                   var usuario = Usuario()
                   
                   usuario.IdUsuario = Int(txtActualizarEliminar.text!) ?? 0
                   usuario.Nombre = txtNombre.text!
                   usuario.ApellidoPaterno = txtApellidoPaterno.text!
                   usuario.ApellidoMaterno = txtApellidoMaterno.text!
                   usuario.FechaNacimiento = txtFechaNacimiento.text!
                   usuario.UserName = txtUserName.text!
                   usuario.Password = txtPassword.text!
                   usuario.Rol = Rol()
                   usuario.Rol?.IdRol = self.IdRol
                   
                   Validacion()
                   let result = UsuarioViewModel.Update(usuario: usuario)
                   if result.Correct! {
                       let alert = UIAlertController(title: "Mensaje", message: "Usuario actualizado correctamente", preferredStyle: .alert)
                       let action = UIAlertAction(title: "Aceptar", style: .default)
                       alert.addAction(action)
                       present(alert, animated: true)
                       
                   }
                   else{
                       let alert = UIAlertController(title: "Mensaje", message: "Por favor llena todos los campos solicitados", preferredStyle: .alert)
                       let action = UIAlertAction(title: "Aceptar", style: .default)
                       alert.addAction(action)
                       //alert.showDetailViewController(alert, sender: self)
                       present(alert, animated: true)
                   }
                   break
               default:
                   print("No se realizo nada")
	               }
        
    }
    
    @IBAction func btnActualizar(_ sender: UIButton) {
        var usuario = Usuario()
        usuario.IdUsuario = Int(txtActualizarEliminar.text!)
        usuario.Nombre = txtNombre.text!
        usuario.ApellidoPaterno = txtApellidoPaterno.text!
        usuario.ApellidoMaterno = txtApellidoMaterno.text!
        usuario.FechaNacimiento = txtFechaNacimiento.text!
        usuario.UserName = txtUserName.text!
        usuario.Password = txtPassword.text!
        UsuarioViewModel.Update(usuario: usuario)
    }
    
    @IBAction func btnEliminar(_ sender: UIButton) {
        var IdUsuario = Int(txtActualizarEliminar.text!)
        UsuarioViewModel.Delete(IdUsuario: IdUsuario!)
    }
    
    
    @IBAction func btnGetById(_ sender: UIButton) {
        var IdUsuario = Int(txtActualizarEliminar.text!)
        UsuarioViewModel.GetById(IdUsuario: IdUsuario!)
    }
}
