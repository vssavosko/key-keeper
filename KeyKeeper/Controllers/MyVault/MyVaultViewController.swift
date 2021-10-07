//
//  MyVaultViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 25.07.2021.
//

import UIKit
import SwiftKeychainWrapper

class MyVaultViewController: UIViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let tableView = UITableView()
    
    private var accounts = KeychainWrapper.standard.getAccounts(forKey: Keys.accounts) ?? []
    private var filteredAccounts = [Account]()
    private var isEmptySearchBar: Bool {
        guard let text = searchController.searchBar.text else { return true }
        
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !isEmptySearchBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureNavigationBar()
        configureTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if Core.shared.isFirstLaunch() {
            let onboardingVC = OnboardingViewController()
            
            onboardingVC.modalPresentationStyle = .fullScreen
            
            present(onboardingVC, animated: false)
        }
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
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        definesPresentationContext = true
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

extension MyVaultViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        
        filteredAccounts = accounts.filter({ (account: Account) -> Bool in
            return account.title.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
}

extension MyVaultViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredAccounts.count
        }
        
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyVaultCell.identifier, for: indexPath) as! MyVaultCell
        let currentAccount = isFiltering ? filteredAccounts[indexPath.row] : accounts[indexPath.row]
        
        cell.set(account: currentAccount)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let accountData = isFiltering ? filteredAccounts[indexPath.row] : accounts[indexPath.row]
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
            
            KeychainWrapper.standard.saveAccounts(accounts, forKey: Keys.accounts)
            
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
        
        KeychainWrapper.standard.saveAccounts(accounts, forKey: Keys.accounts)
        
        tableView.reloadData()
    }
    
    func updateAccount(account: Account, indexRow: Int) {
        accounts[indexRow] = account
        
        KeychainWrapper.standard.saveAccounts(accounts, forKey: Keys.accounts)
        
        tableView.reloadData()
    }
    
}
