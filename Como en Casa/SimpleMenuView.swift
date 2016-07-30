//
//  SimpleMenuView.swift
//  Como en Casa
//
//  Created by Rodolfo Castillo on 7/30/16.
//  Copyright © 2016 Rodolfo Castillo. All rights reserved.
//

import UIKit

class simpleMenuView: UIView {
    //ITEMS
    var foodItem: FoodView!
    var leftItem: FoodView!
    var rightItem: FoodView!
    
    //DATA STRUCTURES
    var Items: [Saucer]!
    
    
    //VARIABLES AND HELPERS
    var initLoc: CGFloat = 0
    var itemFlag: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func customInit(){
        //INIT ITEMS
        self.foodItem = FoodView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        self.leftItem = FoodView(frame: self.foodItem.frame)
        self.rightItem = FoodView(frame: self.foodItem.frame)
        
        //POSITIONING
        //FOODITEM AND FRADIENT ARE ALREADY POSITIONED
        self.leftItem.frame.origin.x = 0 - self.leftItem.frame.width
        self.rightItem.frame.origin.x = self.rightItem.frame.width
        
        //STYLING
        self.backgroundColor = UIColor.blackColor()
        
        self.foodItem.clipsToBounds = true
        self.leftItem.clipsToBounds = true
        self.rightItem.clipsToBounds = true
        
        
        //DEBUGGING:: COLORING
        self.foodItem.backgroundColor = UIColor.purpleColor()
        
        self.leftItem.backgroundColor = UIColor.yellowColor()
        self.rightItem.backgroundColor = UIColor.yellowColor()
        
        //DEBUGGING:: POSITIONING ITEMS WITH PHOTOS
        
        //ADDING STUFF
        self.addSubview(foodItem)
        self.addSubview(leftItem)
        self.addSubview(rightItem)
    }
    
    func setItems(items: [Saucer]){
        self.Items = items
        self.correctItemsLocations()
    }
    
    func correctItemsLocations(){
        self.foodItem.frame.origin.x = 0
        self.leftItem.frame.origin.x = 0 - self.frame.width
        self.rightItem.frame.origin.x = self.frame.width
        self.setImages()
    }
    
}

extension simpleMenuView{
    
    //GESTURE CONTROL -------------
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            //            print("Init Loc:\(touch.locationInView(self.view).x)")
            self.initLoc = touch.locationInView(self).x
        }
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let presentLoc: CGFloat = touch.locationInView(self).x
            let centerOfview: CGFloat = self.center.x
            adjustItemsForMovement(centerOfview, referencePoint: presentLoc)
            
        }
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            //            print("End Loc:\(touch.locationInView(self.view).x)")
            let lastPoint: CGFloat = touch.locationInView(self).x
            var factorMoved: CGFloat = 0
            
            if lastPoint > self.initLoc {
                factorMoved = lastPoint - self.initLoc
                if factorMoved >= (self.frame.width / 3) {
                    animateSwipeLeft()
                } else {
                    animateAdjustsItems()
                }
                
            } else if lastPoint < self.initLoc {
                factorMoved = self.initLoc - lastPoint
                if factorMoved >= (self.frame.width / 3) {
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
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3, options: .AllowUserInteraction, animations: {
            self.foodItem.frame.origin.x = 0 - (self.frame.width + 15)
            self.rightItem.frame.origin.x = 0
            }, completion: { (animationFinished: Bool) in
                self.correctItemsLocations()
        })
        if self.itemFlag == (self.Items.count - 1) {
            self.itemFlag = 0
        } else if self.itemFlag < (self.Items.count - 1) {
            self.itemFlag += 1
        }
        print(self.itemFlag)
    }
    
    func animateSwipeLeft(){
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3, options: .AllowUserInteraction, animations: {
            self.foodItem.frame.origin.x = (self.frame.width + 15)
            self.leftItem.frame.origin.x = 0
            }, completion: { (animationFinished: Bool) in
                self.correctItemsLocations()
        })
        
        if self.itemFlag == 0 {
            self.itemFlag = self.Items.count - 1
        } else if self.itemFlag > 0 {
            self.itemFlag -= 1
        }
        
        print(self.itemFlag)
    }
    
    func animateAdjustsItems(){
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3, options: .AllowUserInteraction, animations: {
            self.foodItem.frame.origin.x = 0
            self.leftItem.frame.origin.x = 0 - (self.frame.width + 15)
            self.rightItem.frame.origin.x = (self.frame.width + 15)
            }, completion: nil)
    }
    
    func adjustItemsForMovement(anchorPoint: CGFloat, referencePoint: CGFloat){
        if anchorPoint > self.initLoc {
            self.foodItem.center.x = referencePoint + (anchorPoint - self.initLoc)
            self.leftItem.frame.origin.x = (self.foodItem.frame.origin.x - (self.frame.width + 15))
            self.rightItem.frame.origin.x = (self.foodItem.frame.origin.x + (self.frame.width + 15))
        } else if anchorPoint < self.initLoc {
            self.foodItem.center.x = referencePoint  - (self.initLoc - anchorPoint)
            self.leftItem.frame.origin.x = (self.foodItem.frame.origin.x - (self.frame.width + 15))
            self.rightItem.frame.origin.x = (self.foodItem.frame.origin.x + (self.frame.width + 15))
        }
    }
    
    //IMAGE CLOUSURING AND ASIGNING
    func setImages(){
        loadPhoto(Items[itemFlag], imageView: foodItem)
        if itemFlag == (self.Items.count - 1){
            loadPhoto(Items[0], imageView: rightItem)
            loadPhoto(Items[itemFlag - 1], imageView: leftItem)
        } else if itemFlag == 0 {
            loadPhoto(Items[1], imageView: rightItem)
            loadPhoto(Items[(self.Items.count - 1)], imageView: leftItem)
        } else {
            loadPhoto(Items[itemFlag + 1], imageView: rightItem)
            loadPhoto(Items[itemFlag - 1], imageView: leftItem)
        }
    }
    
    
    
    func loadPhoto(item: Saucer, imageView: FoodView){
        imageView.setText(item.name, cost: item.price, q: item.desiredAmmount)
        
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
                        print("Success")
                        imageView.setImage(item.photo.image!)
                    })
                }
            }
            
            // Run task
            task.resume()
        } else {
            imageView.setImage(item.photo.image!)
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
    

