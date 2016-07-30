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
    
    let aDish = Saucer(name: "Gorditas", photoURL: "", id: "5", price: "50", inStock: 10)
    
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
        self.loadSaucers()
    }
    
    func customInit(){
        //INIT ITEMS
        self.foodItem = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.gradientItem = UIImageView(frame: self.foodItem.frame)
        self.plusButton = UIButton(type: .System)
        self.minusButton = UIButton(type: .System)
        self.plusButton.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        self.minusButton.frame = self.plusButton.frame
        self.countLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        self.leftItem = UIImageView(frame: self.foodItem.frame)
        self.rightItem = UIImageView(frame: self.foodItem.frame)
        
        //POSITIONING
        //FOODITEM AND FRADIENT ARE ALREADY POSITIONED
        self.countLabel.text = "HOLA"
        self.countLabel.center.x = self.view.center.x
        self.minusButton.center = CGPoint(x: (self.view.center.x - (65 + (self.minusButton.frame.width / 2))), y: (self.view.frame.height) - ((self.minusButton.frame.height / 2) + 20))
        self.plusButton.center = CGPoint(x: (self.view.center.x + (65 + (self.minusButton.frame.width / 2))), y:  (self.view.frame.height) - ((self.minusButton.frame.height / 2) + 20))
        self.countLabel.center.y = self.plusButton.center.y
        self.leftItem.frame.origin.x = 0 - self.leftItem.frame.width
        self.rightItem.frame.origin.x = self.rightItem.frame.width
        
        //STYLING
        self.view.backgroundColor = UIColor.blackColor()
        self.minusButton.clipsToBounds = true
        self.plusButton.clipsToBounds = true
        self.minusButton.layer.cornerRadius = self.minusButton.frame.width / 2
        self.plusButton.layer.cornerRadius = self.minusButton.frame.width / 2
        self.countLabel.textAlignment = .Center
        self.countLabel.font = UIFont(name: "Helvetica-Bold", size: 25)
        self.foodItem.clipsToBounds = true
        self.leftItem.clipsToBounds = true
        self.rightItem.clipsToBounds = true
        
        
        //DEBUGGING:: COLORING
        self.foodItem.backgroundColor = UIColor.purpleColor()
        self.gradientItem.backgroundColor = UIColor.clearColor()
        //        self.gradientItem.alpha = 0.5
        self.minusButton.backgroundColor = UIColor.blueColor()
        self.plusButton.backgroundColor = UIColor.redColor()
        self.countLabel.backgroundColor = UIColor.orangeColor()
        self.leftItem.backgroundColor = UIColor.yellowColor()
        self.rightItem.backgroundColor = UIColor.yellowColor()
        
        //DEBUGGING:: POSITIONING ITEMS WITH PHOTOS
        
        //ADDING STUFF
        self.view.addSubview(foodItem)
        self.view.addSubview(leftItem)
        self.view.addSubview(rightItem)
        self.view.addSubview(gradientItem)
        self.view.addSubview(minusButton)
        self.view.addSubview(plusButton)
        self.view.addSubview(countLabel)
    }
    
    func loadSaucers(){
        self.AllSaucers = [Soups, Entries, Dishes, Desserts, Drinks]
        
        self.correctItemsLocations()
    }
    
    func correctItemsLocations(){
        self.foodItem.frame.origin.x = 0
        self.leftItem.frame.origin.x = 0 - self.view.frame.width
        self.rightItem.frame.origin.x = self.view.frame.width
        self.setImages()
    }
    
}

extension FoodMenuController{
    
    //GESTURE CONTROL -------------
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
//            print("Init Loc:\(touch.locationInView(self.view).x)")
            self.initLoc = touch.locationInView(self.view).x
        }
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let presentLoc: CGFloat = touch.locationInView(self.view).x
            let centerOfview: CGFloat = self.view.center.x
//            var factorMoved: CGFloat = 0
//            print("Movint to Loc:\(touch.locationInView(self.view).x)")
//            if presentLoc > self.initLoc {
//                factorMoved = presentLoc - self.initLoc
//                print("USER MOVING TO RIGHT BY: \(factorMoved)")
//                //USER MOVING RIGHT
//            } else if presentLoc < self.initLoc {
//                factorMoved = self.initLoc - presentLoc
//                print("USER MOVING TO LEFT BY: \(factorMoved)")
//                //USER MOVING LEFT
//            }
            
            adjustItemsForMovement(centerOfview, referencePoint: presentLoc)
            
        }
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
//            print("End Loc:\(touch.locationInView(self.view).x)")
            let lastPoint: CGFloat = touch.locationInView(self.view).x
            var factorMoved: CGFloat = 0
            
            if lastPoint > self.initLoc {
                factorMoved = lastPoint - self.initLoc
                if factorMoved >= (self.view.frame.width / 3) {
                    animateSwipeLeft()
                } else {
                    animateAdjustsItems()
                }
                
            } else if lastPoint < self.initLoc {
                factorMoved = self.initLoc - lastPoint
                if factorMoved >= (self.view.frame.width / 3) {
                    animateSwipeRight()
                } else {
                    animateAdjustsItems()
                }
            }
        }
    }
    //----------------GESTURE CONTROL
    
    //ANIMATIONS---------------
    
    //ANIMATIONS FOR SWIPES
    func animateSwipeRight(){
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: [], animations: {
            self.foodItem.frame.origin.x = 0 - self.view.frame.width
            self.rightItem.frame.origin.x = 0
            }, completion: { (animationFinished: Bool) in
                self.correctItemsLocations()
        })
        if self.itemFlag == (self.Soups.count - 1) {
            self.itemFlag = 0
        } else if self.itemFlag < (self.Soups.count - 1) {
            self.itemFlag += 1
        }
        print(self.itemFlag)
    }
    
    func animateSwipeLeft(){
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: [], animations: {
            self.foodItem.frame.origin.x = self.view.frame.width
            self.leftItem.frame.origin.x = 0
            }, completion: { (animationFinished: Bool) in
                self.correctItemsLocations()
        })
        
        if self.itemFlag == 0 {
            self.itemFlag = self.Soups.count - 1
        } else if self.itemFlag > 0 {
            self.itemFlag -= 1
        }
        
        print(self.itemFlag)
    }
    
    func animateAdjustsItems(){
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: [], animations: {
            self.foodItem.frame.origin.x = 0
            self.leftItem.frame.origin.x = 0 - self.view.frame.width
            self.rightItem.frame.origin.x = self.view.frame.width
            }, completion: nil)
    }
    
    func adjustItemsForMovement(anchorPoint: CGFloat, referencePoint: CGFloat){
        if anchorPoint > self.initLoc {
            self.foodItem.center.x = referencePoint + (anchorPoint - self.initLoc)
            self.leftItem.frame.origin.x = (self.foodItem.frame.origin.x - self.foodItem.frame.width)
            self.rightItem.frame.origin.x = (self.foodItem.frame.origin.x + self.foodItem.frame.width)
        } else if anchorPoint < self.initLoc {
            self.foodItem.center.x = referencePoint  - (self.initLoc - anchorPoint)
            self.leftItem.frame.origin.x = (self.foodItem.frame.origin.x - self.foodItem.frame.width)
            self.rightItem.frame.origin.x = (self.foodItem.frame.origin.x + self.foodItem.frame.width)
        }
    }
    
    //IMAGE CLOUSURING AND ASIGNING
    func setImages(){
            loadPhoto(Soups[itemFlag], imageView: foodItem)
            if itemFlag == (self.Soups.count - 1){
                loadPhoto(Soups[0], imageView: rightItem)
                loadPhoto(Soups[itemFlag - 1], imageView: leftItem)
            } else if itemFlag == 0 {
                loadPhoto(Soups[1], imageView: rightItem)
                loadPhoto(Soups[(self.Soups.count - 1)], imageView: leftItem)
            } else {
                loadPhoto(Soups[itemFlag + 1], imageView: rightItem)
                loadPhoto(Soups[itemFlag - 1], imageView: leftItem)
            }
    }
    
    func loadPhoto(item: Saucer, imageView: UIImageView){
        if item.photo.image == nil {
            let url = NSURL(string: item.photoURL)!
            // Download task:
            // - sharedSession = global NSURLCache, NSHTTPCookieStorage and NSURLCredentialStorage objects.
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (responseData, responseUrl, error) -> Void in
                // if responseData is not null...
                if let data = responseData{
                    
                    // execute in UI thread
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        item.photo.image =  UIImage(data: data)
                        imageView.image = item.photo.image
                    })
                }
            }
            
            // Run task
            task.resume()
        } else {
            imageView.image = item.photo.image
        }
        imageView.contentMode = .ScaleAspectFill
        
    }
    
    func imagesAreLoaded(groupDishes: [AnyObject]) -> Bool{
        for item in groupDishes as! [Saucer] {
            if item.photo == nil {
                return false
            }
        }
        return true
    }
    
    //---------------ANIMATIONS
}