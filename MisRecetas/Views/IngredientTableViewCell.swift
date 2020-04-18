//
//  IngredientTableViewCell.swift
//  MisRecetas
//
//  Created by Alicia Ngomo Fernandez on 18/04/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {

    @IBOutlet weak var ingredient: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var measure: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
