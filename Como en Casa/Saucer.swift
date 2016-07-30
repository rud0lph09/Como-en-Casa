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
    var desiredAmmount: Int!
    var abveilableAmmount: Int!
    
    init(name: String, photoURL: String, id: String, price: String, inStock: Int){
        self.name = name
        self.photoURL = photoURL
        self.id = id
        self.price = price
        self.abveilableAmmount = inStock
        self.photo = UIImageView()
    }
    
}