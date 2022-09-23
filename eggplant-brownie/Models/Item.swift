//
//  Item.swift
//  eggplant-brownie
//
//  Created by Matheus Barni on 21/09/22.
//

import UIKit

class Item: NSObject, NSCoding {
    let nome: String
    let calorias: Double
    
    func encode(with coder: NSCoder) {
        coder.encode(self.nome, forKey: "nome")
        coder.encode(self.calorias, forKey: "calorias")
    }
    
    required init?(coder: NSCoder) {
        self.nome = coder.decodeObject(forKey: "nome") as! String
        self.calorias = coder.decodeDouble(forKey: "calorias")
    }
    
    init(nome: String, calorias: Double) {
        self.nome = nome
        self .calorias = calorias
    }
}
