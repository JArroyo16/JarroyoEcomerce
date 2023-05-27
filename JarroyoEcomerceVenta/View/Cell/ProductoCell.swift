//
//  ProductoCell.swift
//  JarroyoEcomerce
//
//  Created by MacBookMBP1 on 16/05/23.
//
import UIKit

class ProductoCell: UITableViewCell {

    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var lblNombre: UILabel!
    
    @IBOutlet weak var lblDepartamento: UILabel!
    
    @IBOutlet weak var lblPrecio: UILabel!
    
    @IBOutlet weak var lblDescrpcion: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
