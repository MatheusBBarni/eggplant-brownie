//
//  Alerta.swift
//  eggplant-brownie
//
//  Created by Matheus Barni on 23/09/22.
//

import UIKit

class Alerta {
    let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func exibe(title: String = "Atenção", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(okButton)
        
        self.viewController.present(alert, animated: true)
    }
}
