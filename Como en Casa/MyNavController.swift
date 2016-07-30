//
//  MyNavController.swift
//  Como en Casa
//
//  Created by Rodolfo Castillo on 7/30/16.
//  Copyright © 2016 Rodolfo Castillo. All rights reserved.
//

import UIKit

class navForMenu: UIView {
    
    //ITEMS
    var titleLabel: UILabel!
    var nextLabel: UILabel!
    var prevLabel: UILabel!
    var dNextLabel: UILabel!
    var dPrevLabel: UILabel!
    
    var littleSquare: UILabel!
    
    var nextButton: UIButton!
    var prevButton: UIButton!
    
    var navFlag = 0
    var navMax = 4
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 65)
        self.titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 35))
        self.nextLabel = UILabel(frame: self.titleLabel.frame)
        self.prevLabel = UILabel(frame: self.titleLabel.frame)
        self.dNextLabel = UILabel(frame: self.titleLabel.frame)
        self.dPrevLabel = UILabel(frame: self.titleLabel.frame)
        self.nextButton = UIButton(frame: CGRect(x: self.frame.width - 100, y: 20, width: 100, height: 45))
        self.prevButton = UIButton(frame: CGRect(x: 0, y: 20, width: 100, height: 45))
        self.littleSquare = UILabel(frame: CGRect(x: 0, y: self.frame.height - 5, width: 80, height: 5))
        
        self.nextButton.addTarget(self, action: #selector(self.animNext(_:)), forControlEvents: .TouchUpInside)
        self.prevButton.addTarget(self, action: #selector(self.animPrev(_:)), forControlEvents: .TouchUpInside)
        
        self.titleLabel.backgroundColor = UIColor.clearColor()
        self.nextLabel.backgroundColor = UIColor.clearColor()
        self.dNextLabel.backgroundColor = UIColor.clearColor()
        self.prevLabel.backgroundColor = UIColor.clearColor()
        self.dPrevLabel.backgroundColor = UIColor.clearColor()
        self.nextButton.backgroundColor = UIColor.clearColor()
        self.prevButton.backgroundColor = UIColor.clearColor()
        self.littleSquare.backgroundColor = UIColor.whiteColor()
        
        self.titleLabel.textColor = UIColor.whiteColor()
        self.nextLabel.textColor = UIColor.whiteColor()
        self.dNextLabel.textColor = UIColor.whiteColor()
        self.prevLabel.textColor = UIColor.whiteColor()
        self.dPrevLabel.textColor = UIColor.whiteColor()
        
        self.titleLabel.textAlignment = .Center
        self.nextLabel.textAlignment = .Center
        self.dNextLabel.textAlignment = .Center
        self.prevLabel.textAlignment = .Center
        self.dPrevLabel.textAlignment = .Center
        self.littleSquare.center.x = self.center.x
        
        self.titleLabel.font = UIFont(name: "Helvetica-Bold", size: 16)
        self.nextLabel.font = UIFont(name: "Helvetica-Bold", size: 16)
        self.dNextLabel.font = UIFont(name: "Helvetica-Bold", size: 16)
        self.prevLabel.font = UIFont(name: "Helvetica-Bold", size: 16)
        self.dPrevLabel.font = UIFont(name: "Helvetica-Bold", size: 16)
        
        
        self.standardArrangmentOfItems()
        self.switchForText()
        
        self.addSubview(titleLabel)
        self.addSubview(nextLabel)
        self.addSubview(dNextLabel)
        self.addSubview(prevLabel)
        self.addSubview(dPrevLabel)
        self.addSubview(nextButton)
        self.addSubview(prevButton)
        self.addSubview(littleSquare)
        
        self.backgroundColor = UIColor(red: 1, green: 129/255, blue: 85/255, alpha: 1)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func standardArrangmentOfItems(){
        self.titleLabel.center.x = self.center.x
        self.nextLabel.center.x = (self.frame.width - 55)
            self.prevLabel.center.x = (55)
        self.dNextLabel.center.x = (self.frame.width + 75)
        self.dPrevLabel.center.x = -75
        self.titleLabel.frame.origin.y = 30
        self.nextLabel.frame.origin.y = 30
        self.dNextLabel.frame.origin.y = 30
        self.prevLabel.frame.origin.y = 30
        self.dPrevLabel.frame.origin.y = 30
    }
    
    func switchForText(){
        switch self.navFlag {
        case 0:
            self.setLabelsText("", PTitle: "", Title: "Sopa", NTitle: "Entrada", dNTitle: "Guisado")
        case 1:
            self.setLabelsText("", PTitle: "Sopa", Title: "Entrada", NTitle: "Guisado", dNTitle: "Bebida")
        case 2:
            self.setLabelsText("Sopa", PTitle: "Entrada", Title: "Guisado", NTitle: "Bebida", dNTitle: "Postre")
        case 3:
            self.setLabelsText("Entrada", PTitle: "Guisado", Title: "Bebida", NTitle: "Postre", dNTitle: "Siguiente")
        case 4:
            self.setLabelsText("Guisado", PTitle: "Bebida", Title: "Postre", NTitle: "Siguiente", dNTitle: "Siguiente")
        default:
            print("Valor incorrecto")
            
        }
    }
    
    func animNext(sender: AnyObject){
        if navFlag < navMax {
            self.littleSquare.center.x = self.nextLabel.center.x
        UIView.animateWithDuration(0.3, animations: {
            if self.navFlag < self.navMax {
                self.littleSquare.center.x = self.center.x
                self.dNextLabel.center = self.nextLabel.center
                self.nextLabel.center = self.titleLabel.center
                self.titleLabel.center = self.prevLabel.center
                self.prevLabel.center = self.dPrevLabel.center
                
            }
            }) { (finished) in
                self.navFlag += 1
                print(self.navFlag)
                self.switchForText()
                self.standardArrangmentOfItems()
            }
        }
    }
    
    func animPrev(sender: AnyObject){
        if navFlag > 0 {
            self.littleSquare.center.x = self.prevLabel.center.x
        UIView.animateWithDuration(0.3, animations: {
                self.littleSquare.center.x = self.center.x
                self.dPrevLabel.center = self.prevLabel.center
                self.prevLabel.center = self.titleLabel.center
                self.titleLabel.center = self.nextLabel.center
                self.nextLabel.center = self.dNextLabel.center
            
        }) { (finished) in
            self.navFlag -= 1
            print(self.navFlag)
            self.switchForText()
            self.standardArrangmentOfItems()
            }
        }
    }
    
    func setLabelsText(dPTitle: String, PTitle: String, Title: String, NTitle: String, dNTitle: String){
        self.dPrevLabel.text = dPTitle
        self.prevLabel.text = PTitle
        self.titleLabel.text = Title
        self.nextLabel.text = NTitle
        self.dNextLabel.text = dNTitle
    }
    
}
