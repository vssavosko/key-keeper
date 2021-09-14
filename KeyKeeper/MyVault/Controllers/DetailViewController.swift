//
//  DetailViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 05.08.2021.
//

import UIKit

protocol UpdateAccountDelegate {
    
    func updateAccount(account: Account, indexRow: Int)
    
}

class DetailViewController: UIViewController {
    
    let dateFormatter = DateFormatter.configure()
    
    var delegate: UpdateAccountDelegate?
    var indexRow: Int?
    
    var accountData: Account!
    
    private let loginLabel = Generator.createLabel(text: "Email or username")
    private let loginField = Generator.createField(contentType: .login, placeholder: "richardhendricks@piedpiper.com")
    private let passwordLabel = Generator.createLabel(text: "Password")
    private let passwordField = Generator.createField(contentType: .password, placeholder: "QwEr123Ty456")
    private let passwordButton = Generator.passwordButton
    private let websiteLabel = Generator.createLabel(text: "Website")
    private let websiteField = Generator.createField(contentType: .website, placeholder: "www.piedpiper.com")
    private let createdLabel = Generator.createLabel(text: "", textAlignment: .center, font: UIFont.systemFont(ofSize: 13, weight: .regular))
    private let lastModifiedLabel = Generator.createLabel(text: "", textAlignment: .center, font: UIFont.systemFont(ofSize: 13, weight: .regular))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureNavigationBar()
        configureSubviews()
        configureFields()
        configureLabels()
    }
    
    func set(account: Account) {
        accountData = account
    }
    
    func configureNavigationBar() {
        navigationItem.title = accountData.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(tapOnEdit))
    }
    
    func configureSubviews() {
        view.addSubview(loginLabel)
        view.addSubview(loginField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordField)
        view.addSubview(passwordButton)
        view.addSubview(websiteLabel)
        view.addSubview(websiteField)
        view.addSubview(createdLabel)
        view.addSubview(lastModifiedLabel)
    }
    
    func configureFields() {
        loginField.text = accountData.login
        passwordField.text = accountData.password
        websiteField.text = accountData.website
        
        loginField.isEnabled = false
        passwordField.isEnabled = false
        websiteField.isEnabled = false
        
        Generator.addBottomLineFor(field: loginField)
        Generator.addBottomLineFor(field: websiteField)
        
        passwordButton.addTarget(self, action: #selector(tapOnPasswordButton), for: .touchUpInside)
        
        setupFieldConstraints()
    }
    
    func configureLabels() {
        createdLabel.isHidden = accountData.createdAt == ""
        lastModifiedLabel.isHidden = accountData.updatedAt == ""
        
        createdLabel.text = "Created: \(DateFormatter.changeDateFormatFor(date: accountData.createdAt))"
        lastModifiedLabel.text = "Last modified: \(DateFormatter.changeDateFormatFor(date: accountData.updatedAt))"
        
        setupLabelConstraints()
    }
    
    func setupFieldConstraints() {
        loginLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                    leading: view.leadingAnchor,
                                    bottom: loginField.topAnchor,
                                    trailing: view.trailingAnchor,
                                    padding: UIEdgeInsets(top: 9, left: 16, bottom: 0, right: 16))
        loginField.anchor(top: nil,
                                    leading: view.leadingAnchor,
                                    bottom: passwordLabel.topAnchor,
                                    trailing: view.trailingAnchor,
                                    padding: UIEdgeInsets(top: 0, left: 16, bottom: 10, right: 16))
        
        passwordLabel.anchor(top: nil,
                             leading: view.leadingAnchor,
                             bottom: passwordField.topAnchor,
                             trailing: view.trailingAnchor,
                             padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        passwordField.anchor(top: nil,
                             leading: view.leadingAnchor,
                             bottom: websiteLabel.topAnchor,
                             trailing: view.trailingAnchor,
                             padding: UIEdgeInsets(top: 0, left: 16, bottom: 41, right: 16))
        
        passwordButton.anchor(top: passwordField.topAnchor,
                              leading: nil,
                              bottom: passwordField.bottomAnchor,
                              trailing: passwordField.trailingAnchor,
                              padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
        websiteLabel.anchor(top: nil,
                            leading: view.leadingAnchor,
                            bottom: websiteField.topAnchor,
                            trailing: view.trailingAnchor,
                            padding: UIEdgeInsets(top: 25, left: 16, bottom: 0, right: 16))
        websiteField.anchor(top: nil,
                            leading: view.leadingAnchor,
                            bottom: createdLabel.topAnchor,
                            trailing: view.trailingAnchor,
                            padding: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16))
    }
    
    func setupLabelConstraints() {
        createdLabel.anchor(top: nil,
                            leading: view.leadingAnchor,
                            bottom: lastModifiedLabel.topAnchor,
                            trailing: view.trailingAnchor,
                            padding: UIEdgeInsets(top: 0, left: 0, bottom: 3, right: 0))
        
        lastModifiedLabel.anchor(top: nil,
                                 leading: view.leadingAnchor,
                                 bottom: nil,
                                 trailing: view.trailingAnchor)
    }
    
    func updateViewControllerData(title: String, login: String, password: String, website: String) {
        self.accountData.title = title
        self.accountData.login = login
        self.accountData.password = password
        self.accountData.website = website
        
        navigationItem.title = title
        loginField.text = login
        passwordField.text = password
        websiteField.text = website
    }
    
    @objc func tapOnPasswordButton(sender: UIButton!) {
        passwordField.isSecureTextEntry = !passwordField.isSecureTextEntry
        
        if passwordField.isSecureTextEntry {
            passwordButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        } else {
            passwordButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        }
    }
    
    @objc func tapOnEdit() {
        let editVC = EditViewController()
        
        editVC.delegate = self
        
        editVC.set(account: accountData)
        
        editVC.completion = { [weak self] (title: String, login: String, password: String, website: String) in
            guard
                let dateFormatter = self?.dateFormatter,
                let indexRow = self?.indexRow,
                let createdAt = self?.accountData.createdAt,
                let lastModifiedLabel = self?.lastModifiedLabel,
                let updateViewControllerData = self?.updateViewControllerData
            else { return }
            
            updateViewControllerData(title, login, password, website)
            
            let updatedAccount = Account(title: title,
                                         login: login,
                                         password: password,
                                         website: website,
                                         createdAt: createdAt,
                                         updatedAt: dateFormatter.string(from: Date()))
            
            lastModifiedLabel.text = "Last modified: \(DateFormatter.changeDateFormatFor(date: updatedAccount.updatedAt))"
            
            if lastModifiedLabel.isHidden {
                lastModifiedLabel.isHidden = false
            }
            
            self!.delegate?.updateAccount(account: updatedAccount, indexRow: indexRow)
        }
        
        navigationController?.pushViewController(editVC, animated: true)
    }
    
}
