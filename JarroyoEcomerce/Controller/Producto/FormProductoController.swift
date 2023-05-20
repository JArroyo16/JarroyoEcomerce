//
//  FormProductoController.swift
//  JarroyoEcomerce
//
//  Created by MacBookMBP1 on 16/05/23.
//

import UIKit
import SwipeCellKit
import iOSDropDown

class FormProductoController: UIViewController {

    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var txtNombre: UITextField!
    
    @IBOutlet weak var txtId: UITextField!
    
    @IBOutlet weak var txtPrecio: UITextField!
    
    @IBOutlet weak var txtStock: UITextField!
    
    
    @IBOutlet weak var ddlArea: DropDown!
    
    
    @IBOutlet weak var ddlDepartamento: DropDown!
    
    
    @IBOutlet weak var ddlProveedor: DropDown!
    
    @IBOutlet weak var txtDescripcion: UITextField!
    
    @IBOutlet weak var btnFunction: UIButton!
    
    let dbManager = DBManger()
    var IdProducto : Int = 0
    var IdDepartamento : Int = 0
    var IdProveedor : Int = 0
    var IdArea : Int = 0
    //var producto = Producto()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ddl de departamento
        txtId.isEnabled = false
        
//        imagePickerController.delegate = self
//        imagePickerController.sourceType = .photoLibrary
//        imagePickerController.isEditing = false
        
        ddlArea.didSelect{selectedText , index,id in
            self.IdArea = id
        }
        ddlArea.optionArray = []
        ddlArea.optionIds = []
        let resultarea = ProductoViewModel.GetAllArea()
        if resultarea.Correct!{
            for objarea in resultarea.Objects!{
                let area = objarea as! Area
                
                ddlArea.optionArray.append(area.Nombre!)
                ddlArea.optionIds?.append(area.IdArea!)
            }
        }
        
        ddlDepartamento.didSelect{selectedText , index ,id in
        self.IdDepartamento = id
          }
        
        ddlDepartamento.optionArray = []
        ddlDepartamento.optionIds = []
        let resultDepartamento = ProductoViewModel.GetAllDepartamento()
        if resultDepartamento.Correct!{
            for objdepartamento in resultDepartamento.Objects!{
                let departamento = objdepartamento as! Departamento

            ddlDepartamento.optionArray.append(departamento.Nombre!)
            ddlDepartamento.optionIds?.append(departamento.IdDepartamento!)
            }
        }


        //ddl proveedor
        ddlProveedor.didSelect{selectText , index , id in
            self.IdProveedor = id

        }
        ddlProveedor.optionArray = []
        ddlProveedor.optionIds = []
        let resultProveedor = ProductoViewModel.GetAllProveedor()
        if resultProveedor.Correct!{
            for objProveedor in resultProveedor.Objects!{
                let proveedor = objProveedor as! Proveedor
                ddlProveedor.optionIds?.append(proveedor.IdProveedor!)
                ddlProveedor.optionArray.append(proveedor.Nombre!)
            }
        }
        if IdProducto == 0{
            var product = Producto()
            self.txtNombre.text = ""
            self.txtStock.text = ""
            self.txtPrecio.text = ""
            self.txtDescripcion.text = ""
            self.ddlProveedor.text = ""
            self.ddlDepartamento.text = ""
            
            btnFunction.backgroundColor = .green
            btnFunction.setTitle("Agregar", for: .normal)
        }else{
            let datos = ProductoViewModel.GetById(IdProducto: IdProducto)
            let product = datos.Object as! Producto
            
            //img
            self.txtId.text = product.IdProducto?.description
            self.txtNombre.text = product.Nombre
            self.txtStock.text = product.Stock?.description
            self.txtPrecio.text = product.PrecioUnitario?.description
            self.ddlProveedor.text = product.Proveedor?.Nombre
            self.ddlDepartamento.text = product.Departamento?.Nombre
            self.txtDescripcion.text = product.Descripcion
            
            btnFunction.backgroundColor = .orange
            btnFunction.setTitle("Actualizar", for: .normal)
        }
    }
    
    @IBAction func openPickerImage() {
            //self.present(imagePickerController, animated: true)
        }
    
    
    @IBAction func btnEnviar(_ sender: UIButton) {
        let opcion = btnFunction.titleLabel?.text
        switch opcion{
        case "Agregar":
            var producto = Producto()
            
            producto.Nombre = txtNombre.text!
            producto.PrecioUnitario = Int(txtPrecio.text!)
            producto.Stock = Int(txtStock.text!)
            producto.Descripcion = txtDescripcion.text!
            
            let img = ImageView.image
            producto.Imagen = convertToBase64()

            producto.Departamento = Departamento()
            producto.Departamento?.IdDepartamento = self.IdDepartamento
            
            producto.Proveedor = Proveedor()
            producto.Proveedor?.IdProveedor = self.IdProveedor
            
            let result = ProductoViewModel.Add(producto: producto)
            if result.Correct!{
                let alert = UIAlertController(title: "Mensaje", message: "Producto agregado con exito", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)
                alert.addAction(action)
                present(alert, animated: true)
                self.txtNombre.text = ""
                self.txtStock.text = ""
                self.txtPrecio.text = ""
                self.txtDescripcion.text = ""
                self.ddlProveedor.text = ""
                self.ddlDepartamento.text = ""

            } else{
                let alert = UIAlertController(title: "Mensaje", message: "Por favor llena los cmapos", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)
                alert.addAction(action)
                present(alert, animated: true)
            }
            break
        case "Actualizar":
            var producto = Producto()
            
            producto.IdProducto = Int(txtId.text!) ?? 0
            producto.Nombre = txtNombre.text!
            producto.PrecioUnitario = Int(txtPrecio.text!)
            producto.Stock = Int(txtStock.text!)
            producto.Descripcion = txtDescripcion.text!
            
            let img = ImageView.image
            producto.Imagen = convertToBase64()
            
            producto.Departamento = Departamento()
            producto.Departamento?.IdDepartamento = self.IdDepartamento
            
            producto.Proveedor = Proveedor()
            producto.Proveedor?.IdProveedor = self.IdProveedor
            
            let result = ProductoViewModel.Update(producto: producto)
            if result.Correct! {
                let alert = UIAlertController(title: "Mensaje", message: "Producto actualizado con exito", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)
                alert.addAction(action)
                self.txtId.text = ""
                self.txtNombre.text = ""
                self.txtStock.text = ""
                self.txtPrecio.text = ""
                self.txtDescripcion.text = ""
                self.ddlProveedor.text = ""
                self.ddlDepartamento.text = ""
                present(alert, animated: true)
            }else{
                let alert = UIAlertController(title: "Mensaje", message: "Por favor llena todos los campos solicitados", preferredStyle: .alert)
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

extension FormProductoController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let data = info[.originalImage]
                self.ImageView.image = info[.originalImage] as! UIImage
                dismiss(animated: true)
            }
    func convertToBase64 () -> String{
            let base64 = (ImageView.image?.pngData()?.base64EncodedString())!
                   //print("Base64 \(base64)")
                   return base64
        }
}

