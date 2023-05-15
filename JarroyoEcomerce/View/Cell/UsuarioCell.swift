//
//  UsuarioCell.swift
//  JarroyoEcomerce
//
//  Created by MacBookMBP1 on 03/05/23.
//

import UIKit
import SwipeCellKit

class UsuarioCell: SwipeTableViewCell {

    
    @IBOutlet weak var txtNombre: UILabel!
    @IBOutlet weak var txtFecha: UILabel!
    @IBOutlet weak var txtUsuario: UILabel!
    
    @IBOutlet weak var txtRol: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        NombreCompleto.translatesAutoresizingMaskIntoConstraints = false
//        Fecha.translatesAutoresizingMaskIntoConstraints = false
//        userName.translatesAutoresizingMaskIntoConstraints = false
//
//        contentView.addSubview(NombreCompleto)
//        contentView.addSubview(Fecha)
//        contentView.addSubview(userName)
//
//        var viewsDict = [
//                    "nombre": NombreCompleto,
//                    "fecha": Fecha,
//                    "username": userName,
//                ]
//        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[nombre]", options: [], metrics: nil, views: viewsDict))
//        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[fecha]", options: [], metrics: nil, views: viewsDict))
//        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[username]", options: [], metrics: nil, views: viewsDict))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
