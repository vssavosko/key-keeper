//
//  MyVaultViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 25.07.2021.
//

import UIKit
import SwiftKeychainWrapper
import Localize_Swift

class MyVaultViewController: UIViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        
        table.register(MyVaultCell.self, forCellReuseIdentifier: MyVaultCell.identifier)
        
        table.translatesAutoresizingMaskIntoConstraints = false
        table.rowHeight = 60
        table.tableFooterView = UIView(frame: .zero)
        
        return table
    }()
    
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
        
        view.backgroundColor = .systemBackground
        
        if Core.shared.isFirstLaunch() {
            UserDefaults.standard.set(0, forKey: Keys.language)
            UserDefaults.standard.set(0, forKey: Keys.theme)
            
            presentViewController(viewController: OnboardingViewController())
        } else {
            presentViewController(viewController: AuthorizationViewController())
        }
        
        configureNavigationBar()
        configureTableView()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "My Vault".localized()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(createAccount))
        
        configureSearchBar()
    }
    
    private func configureSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search".localized()
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        definesPresentationContext = true
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.fillSuperview()
    }
    
    private func presentViewController<T: UIViewController>(viewController: T) {
        viewController.modalPresentationStyle = .fullScreen
        
        present(viewController, animated: false)
    }
    
    @objc private func createAccount() {
        let createVC = CreateViewController()
        
        createVC.hidesBottomBarWhenPushed = true
        
        createVC.delegate = self
        
        navigationController?.pushViewController(createVC, animated: true)
    }
    
}

extension MyVaultViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        
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
