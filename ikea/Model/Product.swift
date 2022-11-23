//
//  Product.swift
//  ikea
//
//  Created by Michele Trombone  on 17/11/22.
//

import Foundation

struct Product: Identifiable
{
    var id : String
    var name : String
    var quantity : Int
    var image : String
    var price : Int
    var description: String
    var dimension: String
    var sound : String
}
