//
//  IkeaModel.swift
//  ikea
//
//  Created by Michele Trombone  on 17/11/22.
//

import Foundation

class IkeaModel : ObservableObject
{
    @Published var products : [Product]
    @Published var supportText : [String]
    @Published var testo : String
    @Published var settingText : [String]
    @Published var yourIkeaText : [String]
    @Published var settingIcon : [String]
    @Published var youtIkeaIcon : [String]
    
    init()
    {
        self.products = [productOne,productTwo,productThree,productFour,productFive,productSix]
        self.supportText = [support1,support2,support3,support4]
        self.testo = ""
        self.settingText = [settingString1,settingString2]
        self.yourIkeaText = [yourIkeaString1,yourIkeaString2,youtIkeaString3]
        self.youtIkeaIcon = ["map","cart","gift"]
        self.settingIcon = ["lock","globe"]
        
    }
    
    
    
    func ScannedProduct() -> Product
    {
        
        var prodottoCheck : Product = Product(id: "", name: "", quantity: 0, image: "", price: 0,description: "",dimension: "",sound:"")
        
        for product in 0...products.count-1
        {
            
            if(testo == products[product].id)
            {
                prodottoCheck = products[product]
            }
        }
        
        return prodottoCheck
    }

}
