//
//  FoodMenuController.swift
//  Como en Casa
//
//  Created by Rodolfo Castillo on 7/30/16.
//  Copyright © 2016 Rodolfo Castillo. All rights reserved.
//

import UIKit

class FoodMenuController: UIViewController {
    //ITEMS
    var foodItem: UIImageView!
    var gradientItem: UIImageView!
    var countLabel: UILabel!
    var plusButton: UIButton!
    var minusButton: UIButton!
    var leftItem: UIImageView!
    var rightItem: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //INIT ITEMS
        self.foodItem = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.gradientItem = UIImageView(frame: self.foodItem.frame)
        self.plusButton = UIButton(type: .System)
        self.minusButton = UIButton(type: .System)
        self.plusButton.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        self.minusButton.frame = self.plusButton.frame
        self.countLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
//        self.leftItem = UIImageView(frame: self.)
        
        //POSITIONING
        //FOODITEM AND FRADIENT ARE ALREADY POSITIONED
        self.countLabel.text = "HOLA"
        self.countLabel.center.x = self.view.center.x
        self.minusButton.center = CGPoint(x: (self.view.center.x - (65 + (self.minusButton.frame.width / 2))), y: (self.view.frame.height) - ((self.minusButton.frame.height / 2) + 20))
        self.plusButton.center = CGPoint(x: (self.view.center.x + (65 + (self.minusButton.frame.width / 2))), y:  (self.view.frame.height) - ((self.minusButton.frame.height / 2) + 20))
        self.countLabel.center.y = self.plusButton.center.y
        
        //STYLING
        self.minusButton.clipsToBounds = true
        self.plusButton.clipsToBounds = true
        self.minusButton.layer.cornerRadius = self.minusButton.frame.width / 2
        self.plusButton.layer.cornerRadius = self.minusButton.frame.width / 2
        self.countLabel.textAlignment = .Center
        self.countLabel.font = UIFont(name: "Helvetica-Bold", size: 25)
        
        
        //DEBUGGING:: COLORING
        self.foodItem.backgroundColor = UIColor.purpleColor()
        self.gradientItem.backgroundColor = UIColor.whiteColor()
        self.gradientItem.alpha = 0.5
        self.minusButton.backgroundColor = UIColor.blueColor()
        self.plusButton.backgroundColor = UIColor.redColor()
        self.countLabel.backgroundColor = UIColor.orangeColor()
        
        //ADDING STUFF
        self.view.addSubview(foodItem)
        self.view.addSubview(gradientItem)
        self.view.addSubview(minusButton)
        self.view.addSubview(plusButton)
        self.view.addSubview(countLabel)
        
        
        
    }
    
}