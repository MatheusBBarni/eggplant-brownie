//
//  AdicionarItensViewController.swift
//  eggplant-brownie
//
//  Created by Matheus Barni on 22/09/22.
//

import UIKit

protocol AdicionaItensDelegate {
    func add(_ item: Item)
}

class AdicionarItensViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var caloriasTextField: UITextField!
    
    // MARK: - Attributes
    
    var delegate: AdicionaItensDelegate?
    
    init(delegate: AdicionaItensDelegate) {
        super.init(nibName: "AdicionarItensViewController", bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBAction
    
    @IBAction func adicionarItem(_ sender: Any) {
        guard let nome = nomeTextField.text, let caloriasItem = caloriasTextField.text else { return }
        guard let calorias = Double(caloriasItem) else { return }
        
        let item = Item(nome: nome, calorias: calorias)
        
        self.delegate?.add(item)
        navigationController?.popViewController(animated: true)
    }

}
