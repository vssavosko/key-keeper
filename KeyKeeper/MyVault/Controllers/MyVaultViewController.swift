//
//  MyVaultViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 25.07.2021.
//

import UIKit

class MyVaultViewController: UIViewController {
    
    var accounts = [Account(title: "Netflix",
                            emailOrUsername: "Netflix Desc",
                            password: "123456",
                            website: "https://netflix.com",
                            createdAt: "",
                            updatedAt: ""),
                    Account(title: "VK",
                            emailOrUsername: "VK Desc",
                            password: "123456",
                            website: "https://vk.com",
                            createdAt: "",
                            updatedAt: ""),
                    Account(title: "Instagram",
                            emailOrUsername: "Instagram Desc",
                            password: "123456",
                            website: "https://instagram.com",
                            createdAt: "",
                            updatedAt: "")]
    
    let searchController = UISearchController(searchResultsController: nil)
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureNavigationBar()
        configureTableView()
    }
    
    func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "My Vault"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createAccount))
        
        configureSearchBar()
    }
    
    func configureSearchBar() {
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.register(MyVaultCell.self, forCellReuseIdentifier: MyVaultCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 60
        tableView.tableFooterView = UIView(frame: .zero)
        
        setupTableViewConstraints()
    }
    
    func setupTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.fillSuperview()
    }
    
    @objc func createAccount() {
        let createVC = CreateViewController()
        
        createVC.hidesBottomBarWhenPushed = true
        
        createVC.delegate = self
        
        navigationController?.pushViewController(createVC, animated: true)
    }
    
}

extension MyVaultViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyVaultCell.identifier, for: indexPath) as! MyVaultCell
        let currentAccount = accounts[indexPath.row]
        
        cell.set(account: currentAccount)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let accountData = accounts[indexPath.row]
        let destination = DetailViewController()
        
        destination.hidesBottomBarWhenPushed = true
        
        destination.delegate = self
        destination.indexRow = indexPath.row
        
        destination.set(account: accountData)
        
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            tableView.beginUpdates()
            
            accounts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
        default:
            break
        }
    }
    
}

extension MyVaultViewController: AddAccountDelegate, UpdateAccountDelegate {
    
    func addAccount(account: Account) {
        accounts.append(account)
        
        tableView.reloadData()
    }
    
    func updateAccount(account: Account, indexRow: Int) {
        accounts[indexRow] = account
        
        tableView.reloadData()
    }
    
}
