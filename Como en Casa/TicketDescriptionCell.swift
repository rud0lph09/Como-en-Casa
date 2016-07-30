//
//  TicketDescriptionCell.swift
//  Como en Casa
//
//  Created by Jonathan Velazquez on 30/07/16.
//  Copyright © 2016 Rodolfo Castillo. All rights reserved.
//

import UIKit

class TicketDescriptionCell: UITableViewCell {
    
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    func setCell(quantity:Int, description:String, price:Int) {
        quantityLabel.text = "\(quantity)"
        descriptionLabel.text = description
        priceLabel.text = "\(price).00"
    }

    
    
}
