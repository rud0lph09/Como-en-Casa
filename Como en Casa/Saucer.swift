//
//  Saucer.swift
//  Como en Casa
//
//  Created by Rodolfo Castillo on 7/30/16.
//  Copyright © 2016 Rodolfo Castillo. All rights reserved.
//

import UIKit


class Saucer {
    var name: String!
    var photoURL: String!
    var photo: UIImageView!
    var id: String!
    var price: String!
    var desiredAmmount: Int = 0
    var abveilableAmmount: Int!
    var type: Int!
    
    init(name: String, photoURL: String, id: String, price: String, inStock: Int, type: Int){
        self.name = name
        self.photoURL = photoURL
        self.id = id
        self.price = price
        self.abveilableAmmount = inStock
        self.photo = UIImageView()
        self.type = type
    }
    
    func setDisiredAmmount(n: Int){
        self.desiredAmmount = n
    }
    
}