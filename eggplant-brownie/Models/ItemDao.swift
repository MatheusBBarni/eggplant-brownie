//
//  ItemDao.swift
//  eggplant-brownie
//
//  Created by Matheus Barni on 23/09/22.
//

import UIKit

class ItemDao {
    private static func recuperaDiretorio() -> URL? {
        guard let folder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let path = folder.appendingPathComponent("itens")
        
        return path
    }
    
    static func save(_ items: Array<Item>) {
        guard let path = self.recuperaDiretorio() else { return }
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: items, requiringSecureCoding: false)
            
            try data.write(to: path)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func getItens() -> Array<Item> {
        guard let path = self.recuperaDiretorio() else { return [] }
        
        do {
            let data = try Data(contentsOf: path)
            guard let savedItems = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Array<Item> else { return [] }
            
            return savedItems
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
