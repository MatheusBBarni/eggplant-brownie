//
//  RefeicoesTableViewController.swift
//  eggplant-brownie
//
//  Created by Matheus Barni on 21/09/22.
//

import UIKit

class RefeicoesTableViewController: UITableViewController, AdiconaRefeicaoDelegate {
    var refeicoes: Array<Refeicao> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refeicoes = RefeicaoDao.getRefeicoes()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "adicionar" {
            if let viewController = segue.destination as? ViewController {
                viewController.delegate = self
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.refeicoes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        let refeicao = self.refeicoes[indexPath.row]
        
        cell.textLabel?.text = refeicao.nome
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(mostrarDetalhes(_:)))
        
        cell.addGestureRecognizer(longPress)
        
        return cell
    }
    
    @objc func mostrarDetalhes(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let cell = gesture.view as! UITableViewCell
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            
            let refeicao = self.refeicoes[indexPath.row]
            
            RemoveRefeicaoViewController(viewController: self).exibe(refeicao, handleRemove: {_ in
                self.refeicoes.remove(at: indexPath.row)
                self.tableView.reloadData()
            })
        }
    }
    
    func add(_ refeicao: Refeicao) {
        self.refeicoes.append(refeicao)
        tableView.reloadData()
        
        RefeicaoDao.save(self.refeicoes)
    }
}
