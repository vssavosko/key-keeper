//
//  CreateAccountViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 27.07.2021.
//

import UIKit

protocol AddAccountDelegate {
    
    func addAccount(account: Account)
    
}

class CreateViewController: UIViewController {
    
    let dateFormatter = DateFormatter.configure()
    
    var delegate: AddAccountDelegate?
    
    private let nameLabel = FieldGenerator.createLabel(text: "Name")
    private let nameField = FieldGenerator.createField(placeholder: "Pied Piper")
    private let loginLabel = FieldGenerator.createLabel(text: "Email or username")
    private let loginField = FieldGenerator.createField(placeholder: "richardhendricks@piedpiper.com")
    private let passwordLabel = FieldGenerator.createLabel(text: "Password")
    private let passwordField = FieldGenerator.createField(isPassword: true, placeholder: "QwEr123Ty456")
    private let passwordButton = FieldGenerator.passwordButton
    private let websiteLabel = FieldGenerator.createLabel(text: "Website")
    private let websiteField = FieldGenerator.createField(placeholder: "https://www.piedpiper.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureNavigationBar()
        configureSubviews()
        configureFields()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.popViewController(animated: false)
    }
    
    func configureNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Create"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(tapOnCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(tapOnSave))
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    func configureSubviews() {
        view.addSubview(nameLabel)
        view.addSubview(nameField)
        view.addSubview(loginLabel)
        view.addSubview(loginField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordField)
        view.addSubview(passwordButton)
        view.addSubview(websiteLabel)
        view.addSubview(websiteField)
    }
    
    func configureFields() {
        FieldGenerator.addBottomLineFor(field: nameField)
        FieldGenerator.addBottomLineFor(field: loginField)
        FieldGenerator.addBottomLineFor(field: websiteField)
        
        nameField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        loginField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordButton.addTarget(self, action: #selector(tapOnPasswordButton), for: .touchUpInside)
        
        passwordButton.isEnabled = false
        
        setupFieldConstraints()
    }
    
    func setupFieldConstraints() {
        nameLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         leading: view.leadingAnchor,
                         bottom: nameField.topAnchor,
                         trailing: view.trailingAnchor,
                         padding: UIEdgeInsets(top: 25, left: 16, bottom: 0, right: 16))
        nameField.anchor(top: nil,
                         leading: view.leadingAnchor,
                         bottom: loginLabel.topAnchor,
                         trailing: view.trailingAnchor,
                         padding: UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16))
        
        loginLabel.anchor(top: nil,
                                    leading: view.leadingAnchor,
                                    bottom: loginField.topAnchor,
                                    trailing: view.trailingAnchor,
                                    padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
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
                            bottom: nil,
                            trailing: view.trailingAnchor,
                            padding: UIEdgeInsets(top: 0, left: 16, bottom: 1, right: 16))
    }
    
    @objc func tapOnCancel() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func tapOnSave() {
        guard let title = nameField.text,
              let login = loginField.text
        else { return }
        
        let newAccount = Account(title: title,
                                 login: login,
                                 password: passwordField.text ?? "",
                                 website: websiteField.text ?? "",
                                 createdAt: dateFormatter.string(from: Date()),
                                 updatedAt: "")
        
        delegate?.addAccount(account: newAccount)
        
        navigationController?.popViewController(animated: true)
    }
    @objc func textFieldDidChange() {
        if !nameField.hasText || !loginField.hasText || !passwordField.hasText {
            navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
        
        if !passwordField.hasText {
            passwordButton.isEnabled = false
        } else {
            passwordButton.isEnabled = true
        }
    }
    @objc func tapOnPasswordButton(sender: UIButton!) {
        passwordField.isSecureTextEntry = !passwordField.isSecureTextEntry
        
        if passwordField.isSecureTextEntry {
            passwordButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        } else {
            passwordButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        }
    }
    
}
