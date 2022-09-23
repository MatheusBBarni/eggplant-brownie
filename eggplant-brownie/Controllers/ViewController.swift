//
//  ViewController.swift
//  eggplant-brownie
//
//  Created by Matheus Barni on 21/09/22.
//

import UIKit

protocol AdiconaRefeicaoDelegate {
    func add(_ refeicao: Refeicao)
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AdicionaItensDelegate {
    // MARK: - Attributes
    
    var delegate: AdiconaRefeicaoDelegate?
    var itens: Array<Item> = []
    var itensSelecionados: Array<Item> = []
    
    
    // MARK: - IBOutlets
    
    @IBOutlet var nomeTextField: UITextField?
    @IBOutlet var felicidadeTextField: UITextField?
    @IBOutlet weak var tabelaItensView: UITableView?
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        let botaoAdicionaItem = UIBarButtonItem(title: "Adicionar", style: .plain, target: self, action: #selector(adicionarItem))
        navigationItem.rightBarButtonItem = botaoAdicionaItem
        
        self.recuperaItens()
    }
    
    @objc func adicionarItem() {
        let adicionarItensViewController = AdicionarItensViewController(delegate: self)
        navigationController?.pushViewController(adicionarItensViewController, animated: true)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        let item = self.itens[indexPath.row]
        cell.textLabel?.text = item.nome
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        if cell.accessoryType == .none {
            cell.accessoryType = .checkmark
            
            let item = self.itens[indexPath.row]
            self.itensSelecionados.append(item)
        } else {
            cell.accessoryType = .none
            let item = self.itens[indexPath.row]
            if let position = self.itensSelecionados.firstIndex(of: item) {
                self.itensSelecionados.remove(at: position)
            }
            
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func adicionar(_ sender: Any) {
        guard let refeicao = self.recuperaRefeicaoFormulario() else {
            Alerta(viewController: self).exibe(message: "Não foi possivel criar uma refeição!")
            return
        }
        
        delegate?.add(refeicao)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Methods
    
    func recuperaRefeicaoFormulario() -> Refeicao? {
        let alerta = Alerta(viewController: self)
        
        guard let nomeRefeicao = nomeTextField?.text else {
            alerta.exibe(message: "Erro ao ler o campo nome")
            return nil
        }
        guard let felicidadeRefeicao = felicidadeTextField?.text, let felicidade = Int(felicidadeRefeicao) else {
            alerta.exibe(message: "Erro ao ler o campo felicidade")
            return nil
        }
        
        let refeicao = Refeicao(nome: nomeRefeicao, felicidade: felicidade, items: itensSelecionados)
        
        return refeicao
    }
    
    func recuperaItens() {
        self.itens = ItemDao.getItens()
    }
    
    func add(_ item: Item) {
        self.itens.append(item)
        ItemDao.save(self.itens)
        
        if let tableView = tabelaItensView {
            tableView.reloadData()
        } else {
            Alerta(viewController: self).exibe(title: "Desculpe", message: "Não foi possivel atualizar a tabela")
        }
    }
}

