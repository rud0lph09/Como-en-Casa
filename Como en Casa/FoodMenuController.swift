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
    var plusButton: UIButton!
    var minusButton: UIButton!
    
    //VIEWS
    var SoupsView: simpleMenuView!
    var EntriesView: simpleMenuView!
    var DishesView: simpleMenuView!
    var DessertView: simpleMenuView!
    var DrinksView: simpleMenuView!
    var allDishViews: [simpleMenuView!] = []
    
    var navBar: navForMenu!
    
    //DATA STRUCTURES
    var Soups: [Saucer] = [Saucer(name: "Gorditas", photoURL: "https://thefridaylunch.files.wordpress.com/2010/01/dscn4419.jpg", id: "5", price: "50", inStock: 10), Saucer(name: "Gorditas", photoURL: "http://www.quesadillasmari.com/wp-content/uploads/2012/01/Gordita-mari.jpg", id: "5", price: "50", inStock: 10), Saucer(name: "Gorditas", photoURL: "http://a-muse-of-food.com/wordpress/wp-content/uploads/2015/06/gorditas-with-beef-01.jpg", id: "5", price: "50", inStock: 10)]
    var Entries: [Saucer] = []
    var Dishes: [Saucer] = []
    var Desserts: [Saucer] = []
    var Drinks: [Saucer] = []
    var AllSaucers: [[Saucer]]!
    
    //VARIABLES AND HELPERS
    var initLoc: CGFloat = 0
    var itemFlag: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customInit()
    }
    
    func customInit(){
        
        self.plusButton = UIButton(type: .System)
        self.minusButton = UIButton(type: .System)
        self.plusButton.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        self.minusButton.frame = self.plusButton.frame
        self.SoupsView = simpleMenuView(frame: CGRect(x: 0, y: 65, width: self.view.frame.width, height: (self.view.frame.height - 45)))
        self.navBar = navForMenu(frame: self.view.frame)
        
        self.SoupsView.setItems(Soups)
        
        self.minusButton.center = CGPoint(x: (self.view.center.x - (65 + (self.minusButton.frame.width / 2))), y: (self.view.frame.height) - ((self.minusButton.frame.height / 2) + 20))
        self.plusButton.center = CGPoint(x: (self.view.center.x + (65 + (self.minusButton.frame.width / 2))), y:  (self.view.frame.height) - ((self.minusButton.frame.height / 2) + 20))
        
        self.minusButton.clipsToBounds = true
        self.plusButton.clipsToBounds = true
        self.minusButton.layer.cornerRadius = self.minusButton.frame.width / 2
        self.plusButton.layer.cornerRadius = self.minusButton.frame.width / 2
        
        self.minusButton.backgroundColor = FancyOrange
        self.plusButton.backgroundColor = FancyOrange
        self.plusButton.layer.borderWidth = 6
        self.plusButton.layer.borderColor = BluedWhite.CGColor
        self.minusButton.layer.borderColor = BluedWhite.CGColor
        self.minusButton.layer.borderWidth = 6
        
        self.plusButton.setTitle("+", forState: .Normal)
        self.plusButton.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 30)
        self.minusButton.setTitle("-", forState: .Normal)
        self.minusButton.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 30)
        self.plusButton.setTitleColor(BluedWhite, forState: .Normal)
        self.minusButton.setTitleColor(BluedWhite, forState: .Normal)
        
        self.minusButton.addTarget(self, action: #selector(self.minusItem(_:)), forControlEvents: .TouchUpInside)
        self.plusButton.addTarget(self, action: #selector(self.plusItem(_:)), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(SoupsView)
        self.view.addSubview(minusButton)
        self.view.addSubview(plusButton)
        self.view.addSubview(navBar)
        
        self.AllSaucers = [Soups, Entries, Dishes, Drinks, Desserts]
        self.allDishViews = [SoupsView, EntriesView, DishesView, DrinksView, DessertView]
    }
    
    
    
}

extension FoodMenuController{
    
    func plusItem(sender: AnyObject){
        self.AllSaucers[navBar.navFlag][self.allDishViews[navBar.navFlag].itemFlag].desiredAmmount += 1
        self.allDishViews[navBar.navFlag].setImages()
        
    }
    
    func minusItem(sender: AnyObject){
        self.AllSaucers[navBar.navFlag][self.allDishViews[navBar.navFlag].itemFlag].desiredAmmount -= 1
        self.allDishViews[navBar.navFlag].setImages()
    }
    
    
}