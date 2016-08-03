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
    var abner = NSDictionary()
    var allDishViews: [simpleMenuView!] = []
    
    var circle: UILabel!
    
    var navBar: navForMenu!
    
    //DATA STRUCTURES
    var Soups: [Saucer] = []
    var Entries: [Saucer] = []
    var Dishes: [Saucer] = []
    var Desserts: [Saucer] = []
    var Drinks: [Saucer] = []
    var AllSaucers: [[Saucer]]!
    
    
    
    //VARIABLES AND HELPERS
    var initLoc: CGFloat = 0
    var itemFlag: Int = 0
    
    override func viewDidLoad() {
        
        self.navigationController?.navigationBar.hidden = true
        
        super.viewDidLoad()
        self.circle = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.circle.clipsToBounds = true
        self.circle.layer.cornerRadius = 50
        self.circle.backgroundColor = UIColor.whiteColor()
        self.circle.center = self.view.center
        self.view.addSubview(circle)
        self.animationForLoadingScreen()
        self.view.backgroundColor = FancyOrange
        getMenu()
        
        
    }
    
    func animationForLoadingScreen(){
        UIView.animateWithDuration(0.3, animations: {
            self.circle.transform = CGAffineTransformMakeScale(0.1, 0.1)
        })
        UIView.animateWithDuration(0.4, delay: 0.31, options: [], animations: {
            self.circle.transform = CGAffineTransformIdentity
            }) { (finished) in
                self.animationForLoadingScreen()
        }
    }
    
    func setInfoInDict(info: NSDictionary){
        self.abner = info
    }
    
    func customInit(){
        
        
        
        self.plusButton = UIButton(type: .System)
        self.minusButton = UIButton(type: .System)
        self.plusButton.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        self.minusButton.frame = self.plusButton.frame
        self.SoupsView = simpleMenuView(frame: CGRect(x: 0, y: 65, width: self.view.frame.width, height: (self.view.frame.height - 45)))
        self.EntriesView = simpleMenuView(frame: self.SoupsView.frame)
        self.DishesView = simpleMenuView(frame: self.SoupsView.frame)
        self.DrinksView = simpleMenuView(frame: self.SoupsView.frame)
        self.DessertView = simpleMenuView(frame: self.SoupsView.frame)
        self.navBar = navForMenu(frame: self.view.frame)
        
        self.navBar.callParent(self)
        
        self.SoupsView.setItems(Soups)
        self.EntriesView.setItems(Entries)
        self.DishesView.setItems(Dishes)
        self.DrinksView.setItems(Drinks)
        self.DessertView.setItems(Desserts)
        
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
        self.view.addSubview(DessertView)
        self.view.addSubview(DrinksView)
        self.view.addSubview(DishesView)
        self.view.addSubview(EntriesView)
        self.view.addSubview(SoupsView)
        self.view.addSubview(minusButton)
        self.view.addSubview(plusButton)
        self.view.addSubview(navBar)
        
        self.AllSaucers = [Soups, Entries, Dishes, Drinks, Desserts]
        self.allDishViews = [SoupsView, EntriesView, DishesView, DrinksView, DessertView]
    }
    
    func alwaysInFront(){
        self.view.bringSubviewToFront(minusButton)
        self.view.bringSubviewToFront(plusButton)
        self.view.bringSubviewToFront(navBar)
    }
    
    func switchForMenus(){
        switch self.navBar.navFlag {
        case 0:
            self.view.bringSubviewToFront(SoupsView)
        case 1:
            self.view.bringSubviewToFront(EntriesView)
        case 2:
            self.view.bringSubviewToFront(DishesView)
        case 3:
            self.view.bringSubviewToFront(DrinksView)
        case 4:
            self.view.bringSubviewToFront(DessertView)
        default:
            print("Invalid Value")
            
        }
        self.alwaysInFront()
    }
    
    func checkOrder(){
        var order = [[String:String]]()
        
        for i in AllSaucers {
            for n in i {
                switch n.type {
                case 0 :
                    order.append(["soup_id": n.id, "soup_amount": "\(n.desiredAmmount)", "price": n.price, "name": n.name])
                case 1:
                    order.append(["entry_id": n.id, "entry_amount": "\(n.desiredAmmount)", "price": n.price, "name": n.name])
                case 2:
                    order.append(["dish_id": n.id, "dish_amount": "\(n.desiredAmmount)", "price": n.price, "name": n.name])
                case 3:
                    order.append(["drink_id": n.id, "drink_amount": "\(n.desiredAmmount)", "price": n.price, "name": n.name])
                case 4:
                    order.append(["dessert_id": n.id, "dessert_amount": "\(n.desiredAmmount)", "price": n.price, "name": n.name])
                default:
                    print("")
                }
            }
        }
        
        var orderWrapUp: [String: AnyObject] = ["orders": order]
        let uDef = NSUserDefaults.standardUserDefaults()
        uDef.setObject(orderWrapUp, forKey: "lastOrder")
        uDef.synchronize()
    }
    
}

extension FoodMenuController{
    
    func plusItem(sender: AnyObject){
        
        self.AllSaucers[navBar.navFlag][self.allDishViews[navBar.navFlag].itemFlag].desiredAmmount += 1
        self.allDishViews[navBar.navFlag].setImages()
        
    }
    
    func minusItem(sender: AnyObject){
        if self.AllSaucers[navBar.navFlag][self.allDishViews[navBar.navFlag].itemFlag].desiredAmmount > 0 {
                self.AllSaucers[navBar.navFlag][self.allDishViews[navBar.navFlag].itemFlag].desiredAmmount -= 1
        }
        self.allDishViews[navBar.navFlag].setImages()
    }
    
    func getMenu(){
        
        
        let myUrl = NSURL(string: "https://comoencasaapp.herokuapp.com/menu")
        let request = NSMutableURLRequest(URL:myUrl!);
        
        
        request.HTTPMethod = "GET"
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
//            print("responseString = \(responseString)")
            
            
            // Convert server json response to NSDictionary
            do {
                if let convertedJsonIntoDict = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                    
                    // Print out dictionary
                    
                    for item in (convertedJsonIntoDict.valueForKey("soups") as! [NSDictionary]) {
                        let name: String = (item.valueForKey("name")!) as! String
                        let photo: String = (item.valueForKey("photo")!) as! String
                        let id: String = "\(item.valueForKey("id")!)"
                        let price: String = "\(item.valueForKey("price")!)"

                        self.Soups.append(Saucer(name: name, photoURL: photo, id: id, price: price, inStock: 10, type: 0))
                    }
                    
                    for item in (convertedJsonIntoDict.valueForKey("entries") as! [NSDictionary]) {
                        let name: String = (item.valueForKey("name")!) as! String
                        let photo: String = (item.valueForKey("photo")!) as! String
                        let id: String = "\(item.valueForKey("id")!)"
                        let price: String = "\(item.valueForKey("price")!)"
                        
                        self.Entries.append(Saucer(name: name, photoURL: photo, id: id, price: price, inStock: 10, type: 1))
                    }
                    
                    for item in (convertedJsonIntoDict.valueForKey("dishes") as! [NSDictionary]) {
                        let name: String = (item.valueForKey("name")!) as! String
                        let photo: String = (item.valueForKey("photo")!) as! String
                        let id: String = "\(item.valueForKey("id")!)"
                        let price: String = "\(item.valueForKey("price")!)"
                        
                        self.Dishes.append(Saucer(name: name, photoURL: photo, id: id, price: price, inStock: 10, type: 2))
                    }
                    
                    for item in (convertedJsonIntoDict.valueForKey("drinks") as! [NSDictionary]) {
                        let name: String = (item.valueForKey("name")!) as! String
                        let photo: String = (item.valueForKey("photo")!) as! String
                        let id: String = "\(item.valueForKey("id")!)"
                        let price: String = "\(item.valueForKey("price")!)"
                        
                        self.Drinks.append(Saucer(name: name, photoURL: photo, id: id, price: price, inStock: 10, type: 3))
                    }
                    
                    for item in (convertedJsonIntoDict.valueForKey("desserts") as! [NSDictionary]) {
                        let name: String = (item.valueForKey("name")!) as! String
                        let photo: String = (item.valueForKey("photo")!) as! String
                        let id: String = "\(item.valueForKey("id")!)"
                        let price: String = "\(item.valueForKey("price")!)"
                        
                        self.Desserts.append(Saucer(name: name, photoURL: photo, id: id, price: price, inStock: 10, type: 4))
                    }
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                        dispatch_async(dispatch_get_main_queue(), {
                            self.customInit()
                        })
                    })
                    
                    
                    
                    
                    
//                    print(((convertedJsonIntoDict.valueForKey("soups") as! [NSDictionary])[0]).valueForKey("name")!)
                    // Get value by key
                    
                    
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            
        }
        task.resume()
    }
    
    
}