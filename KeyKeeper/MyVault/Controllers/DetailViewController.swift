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
    var accountTitle: String?
    var emailOrUsername: String?
    var password: String?
    var website: String?
    var createdAt: String?
    var updatedAt: String?
    
    private let emailOrUsernameLabel = FieldsGenerator.createLabel(text: "Email or username")
    private let emailOrUsernameField = FieldsGenerator.createField(placeholder: "richardhendricks@piedpiper.com")
    private let passwordLabel = FieldsGenerator.createLabel(text: "Password")
    private let passwordField = FieldsGenerator.createField(isPassword: true, placeholder: "QwEr123Ty456")
    private let passwordButton = FieldsGenerator.passwordButton
    private let websiteLabel = FieldsGenerator.createLabel(text: "Website")
    private let websiteField = FieldsGenerator.createField(placeholder: "http://www.piedpiper.com")
    private let createdLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .systemGray
        
        return label
    }()
    private let lastModifiedLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .systemGray
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureNavigationBar()
        configureSubviews()
        configureFields()
        configureLabels()
    }
    
    func configureNavigationBar() {
        navigationItem.title = accountTitle
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
        emailOrUsernameField.text = emailOrUsername
        passwordField.text = password
        websiteField.text = website
        
        emailOrUsernameField.isUserInteractionEnabled = false
        passwordField.isUserInteractionEnabled = false
        websiteField.isUserInteractionEnabled = false
        
        FieldsGenerator.addBottomLineFor(field: emailOrUsernameField)
        FieldsGenerator.addBottomLineFor(field: websiteField)
        
        passwordButton.addTarget(self, action: #selector(tapOnPasswordButton), for: .touchUpInside)
        
        setupFieldConstraints()
    }
    
    func configureLabels() {
        createdLabel.isHidden = createdAt == ""
        lastModifiedLabel.isHidden = updatedAt == ""
        
        guard let createdAt = createdAt,
              let updatedAt = updatedAt
        else { return }
        
        createdLabel.text = "Created: \(DateFormatter.changeDateFormatFor(date: createdAt))"
        lastModifiedLabel.text = "Last modified: \(DateFormatter.changeDateFormatFor(date: updatedAt))"
        
        setupLabelConstraints()
    }
    
    func setupFieldConstraints() {
        emailOrUsernameLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                    leading: view.leadingAnchor,
                                    bottom: emailOrUsernameField.topAnchor,
                                    trailing: view.trailingAnchor,
                                    padding: UIEdgeInsets(top: 5, left: 16, bottom: 0, right: 16))
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
        self.accountTitle = title
        self.emailOrUsername = emailOrUsername
        self.password = password
        self.website = website
        
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
        editVC.accountTitle = accountTitle
        editVC.emailOrUsername = emailOrUsername
        editVC.password = password
        editVC.website = website
        
        editVC.completion = { [weak self] (title: String, emailOrUsername: String, password: String, website: String) in
            guard
                let dateFormatter = self?.dateFormatter,
                let indexRow = self?.indexRow,
                let createdAt = self?.createdAt,
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
