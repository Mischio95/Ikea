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
    
    init()
    {
        self.products = [productOne,productTwo,productThree,productThree]
        self.supportText = [support1,support2,support3,support4]
    }
    
    
    
    
}
