//
//  RefeicaoDao.swift
//  eggplant-brownie
//
//  Created by Matheus Barni on 23/09/22.
//

import UIKit

class RefeicaoDao {
    private static func recuperaDiretorio() -> URL? {
        guard let folder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let path = folder.appendingPathComponent("refeicao")
        
        return path
    }
    
    static func save(_ refeicoes: Array<Refeicao>) {
        guard let path = self.recuperaDiretorio() else { return }
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: refeicoes, requiringSecureCoding: false)
            
            try data.write(to: path)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func getRefeicoes() -> Array<Refeicao> {
        guard let path = self.recuperaDiretorio() else { return [] }
        
        do {
            let data = try Data(contentsOf: path)
            guard let savedRefeicoes = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Array<Refeicao> else { return [] }
            
            return savedRefeicoes
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
