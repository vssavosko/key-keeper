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
    
    private let emailOrUsernameLabel = FieldGenerator.createLabel(text: "Email or username")
    private let emailOrUsernameField = FieldGenerator.createField(placeholder: "richardhendricks@piedpiper.com")
    private let passwordLabel = FieldGenerator.createLabel(text: "Password")
    private let passwordField = FieldGenerator.createField(isPassword: true, placeholder: "QwEr123Ty456")
    private let passwordButton = FieldGenerator.passwordButton
    private let websiteLabel = FieldGenerator.createLabel(text: "Website")
    private let websiteField = FieldGenerator.createField(placeholder: "https://www.piedpiper.com")
    private let createdLabel = FieldGenerator.createLabel(text: "", textAlignment: .center, font: UIFont.systemFont(ofSize: 13, weight: .regular))
    private let lastModifiedLabel = FieldGenerator.createLabel(text: "", textAlignment: .center, font: UIFont.systemFont(ofSize: 13, weight: .regular))
    
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
        view.addSubview(emailOrUsernameLabel)
        view.addSubview(emailOrUsernameField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordField)
        view.addSubview(passwordButton)
        view.addSubview(websiteLabel)
        view.addSubview(websiteField)
        view.addSubview(createdLabel)
        view.addSubview(lastModifiedLabel)
    }
    
    func configureFields() {
        emailOrUsernameField.text = accountData.emailOrUsername
        passwordField.text = accountData.password
        websiteField.text = accountData.website
        
        emailOrUsernameField.isEnabled = false
        passwordField.isEnabled = false
        websiteField.isEnabled = false
        
        FieldGenerator.addBottomLineFor(field: emailOrUsernameField)
        FieldGenerator.addBottomLineFor(field: websiteField)
        
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
        emailOrUsernameLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                    leading: view.leadingAnchor,
                                    bottom: emailOrUsernameField.topAnchor,
                                    trailing: view.trailingAnchor,
                                    padding: UIEdgeInsets(top: 9, left: 16, bottom: 0, right: 16))
        emailOrUsernameField.anchor(top: nil,
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
    
    func updateViewControllerData(title: String, emailOrUsername: String, password: String, website: String) {
        self.accountData.title = title
        self.accountData.emailOrUsername = emailOrUsername
        self.accountData.password = password
        self.accountData.website = website
        
        navigationItem.title = title
        emailOrUsernameField.text = emailOrUsername
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
        
        editVC.completion = { [weak self] (title: String, emailOrUsername: String, password: String, website: String) in
            guard
                let dateFormatter = self?.dateFormatter,
                let indexRow = self?.indexRow,
                let createdAt = self?.accountData.createdAt,
                let lastModifiedLabel = self?.lastModifiedLabel,
                let updateViewControllerData = self?.updateViewControllerData
            else { return }
            
            updateViewControllerData(title, emailOrUsername, password, website)
            
            let updatedAccount = Account(title: title,
                                         emailOrUsername: emailOrUsername,
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
