//
//  FoodView.swift
//  Como en Casa
//
//  Created by Rodolfo Castillo on 7/30/16.
//  Copyright © 2016 Rodolfo Castillo. All rights reserved.
//

import UIKit

public class FoodView: UIView {
    var photoLocker: UIImageView!
    var graphiteLayer: UIImageView!
    var nameLabel: UILabel!
    var costLabel: UILabel!
    var cuantityLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.cuantityLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        self.cuantityLabel.textAlignment = .Center
        self.cuantityLabel.center.x = self.center.x
        self.cuantityLabel.frame.origin.y = self.frame.height - 100
        self.cuantityLabel.textColor = UIColor.whiteColor()
        self.photoLocker = UIImageView(frame: frame)
        self.graphiteLayer = UIImageView(frame: frame)
        self.graphiteLayer.image = UIImage(named: "graphite")
        self.graphiteLayer.contentMode = .ScaleAspectFill
        self.photoLocker.contentMode = .ScaleAspectFill
        self.photoLocker.clipsToBounds = true
        self.graphiteLayer.clipsToBounds = true
        self.nameLabel = UILabel(frame: CGRect(x: 10, y: 20, width: frame.width - 20, height: 50))
        self.costLabel = UILabel(frame: CGRect(x: 10, y: 80, width: frame.width - 20, height: 30))
        self.costLabel.textColor = UIColor.whiteColor()
        self.nameLabel.textColor = UIColor.whiteColor()
        self.costLabel.font = UIFont(name: "Helvetica-Light", size: 30)
        self.nameLabel.font = UIFont(name: "Helvetica-Light", size: 45)
        self.cuantityLabel.font = UIFont(name: "Helvetica", size: 55)
        
        self.addSubview(photoLocker)
        self.addSubview(graphiteLayer)
        self.addSubview(nameLabel)
        self.addSubview(costLabel)
        self.addSubview(cuantityLabel)
    }
    
    func setText(name: String, cost: String, q: Int){
        self.nameLabel.text = name
        self.costLabel.text = "$\(cost).00 m.n."
        self.cuantityLabel.text = "\(q)"
    }
    
    func setImage(image:UIImage){
        self.photoLocker.image = image
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
