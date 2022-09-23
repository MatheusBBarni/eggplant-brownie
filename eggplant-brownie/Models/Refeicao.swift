//
//  Refeicao.swift
//  eggplant-brownie
//
//  Created by Matheus Barni on 21/09/22.
//

import UIKit

class Refeicao: NSObject, NSCoding {
    let nome: String
    let felicidade: Int
    var items: Array<Item> = []
    
    init(nome: String, felicidade: Int, items: Array<Item> = []) {
        self.nome = nome
        self.felicidade = felicidade
        self.items = items
    }
    
    // MARK: - NSCoding
    
    func encode(with coder: NSCoder) {
        coder.encode(self.nome, forKey: "nome")
        coder.encode(self.felicidade, forKey: "felicidade")
        coder.encode(self.items, forKey: "items")
    }
    
    required init?(coder: NSCoder) {
        self.nome = coder.decodeObject(forKey: "nome") as! String
        self.felicidade = coder.decodeInteger(forKey: "felicidade")
        self.items = coder.decodeObject(forKey: "items") as! Array<Item>
    }
    
    // MARK: - Methods
    
    func caloriasTotal() -> Double {
        return self.items.reduce(0.0) {
            $0 + $1.calorias
        }
    }
    
    func detalhes() -> String {
        var mensagem = "Felicidade: \(self.felicidade)"
        
        for item in self.items {
            mensagem += ", \(item.nome) - calorias: \(item.calorias)"
        }
        
        return mensagem
    }
}
