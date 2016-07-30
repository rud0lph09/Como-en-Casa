//
//  TicketTotalCell.swift
//  Como en Casa
//
//  Created by Jonathan Velazquez on 30/07/16.
//  Copyright © 2016 Rodolfo Castillo. All rights reserved.
//

import UIKit

class TicketTotalCell: UITableViewCell {
    
    @IBOutlet weak var priceLabel: UILabel!
    
    
    func setCell( price:Int) {
        priceLabel.text = "\(price).00"
    }

}
