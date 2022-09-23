//
//  RemoveRefeicaoViewController.swift
//  eggplant-brownie
//
//  Created by Matheus Barni on 23/09/22.
//

import UIKit

class RemoveRefeicaoViewController {
    var viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func exibe(_ refeicao: Refeicao, handleRemove: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: refeicao.nome, message: refeicao.detalhes(), preferredStyle: .alert)
        
        let cancelButton = UIAlertAction(title: "Cancelar", style: .cancel)
        let removeButton = UIAlertAction(title: "Remover", style: .destructive, handler: handleRemove)
        
        alert.addAction(cancelButton)
        alert.addAction(removeButton)
        
        self.viewController.present(alert, animated: true, completion: nil)
    }
}
