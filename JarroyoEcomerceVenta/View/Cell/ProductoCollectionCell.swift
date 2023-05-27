//
//  ProductoCollectionCell.swift
//  JarroyoEcomerce
//
//  Created by MacBookMBP1 on 24/05/23.
//

import UIKit

class ProductoCollectionCell: UICollectionViewCell {

    @IBOutlet weak var Imagen: UIImageView!
    
    @IBOutlet weak var lblNombre: UILabel!
    
    @IBOutlet weak var lblDescripcion: UILabel!
    
    @IBOutlet weak var lblPrecio: UILabel!
        
    @IBOutlet weak var btnCarrito: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
