//
//  TicketBorderCell.swift
//  Como en Casa
//
//  Created by Jonathan Velazquez on 30/07/16.
//  Copyright © 2016 Rodolfo Castillo. All rights reserved.
//

import UIKit

enum TicketBorderPosition {
    case Up, Down;
}

class TicketBorderCell: UITableViewCell {
    @IBOutlet weak var iv: UIImageView!
    
    
    func setCell(borderPosition: TicketBorderPosition) {
        if borderPosition == .Up {
            iv.image = UIImage(named: "TicketBorderUp")
        }else if borderPosition == .Down {
            iv.image = UIImage(named: "TicketBorderDown")
        }
    }

}
