//
//  RolCell.swift
//  JarroyoEcomerce
//
//  Created by MacBookMBP1 on 10/05/23.
//
import SwipeCellKit
import UIKit

class RolCell: SwipeTableViewCell {

    @IBOutlet weak var lblId: UILabel!
    
    @IBOutlet weak var lblRol: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
