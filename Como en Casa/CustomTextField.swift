//
//  CustomTextField.swift
//  Como en Casa
//
//  Created by Jonathan Velazquez on 30/07/16.
//  Copyright © 2016 Rodolfo Castillo. All rights reserved.
//

import UIKit

@IBDesignable
class CustomTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
         configView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
         configView()
    }
    
    @IBInspectable var borderColor:UIColor = UIColor.clearColor() {
        didSet{
            configView()
        }
    }
    
    @IBInspectable var placeHolder:String = "" {
        didSet{
            configView()
        }
    }
    @IBInspectable var placeholderColor:UIColor = UIColor.whiteColor() {
        didSet{
            configView()
        }
    }
    
    
    func configView()  {
        self.layer.cornerRadius = 5
        self.layer.borderColor = borderColor.CGColor
        self.layer.borderWidth = 1
        let borderLeft = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        self.leftView = borderLeft
        self.leftViewMode = .Always
        
        self.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSForegroundColorAttributeName: placeholderColor])
    }
    
}