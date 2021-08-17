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
    
    private let nameField = AccountFields.nameField
    private let emailOrUsernameField = AccountFields.emailOrUsernameField
    private let passwordField = AccountFields.passwordField
    private let passwordButton = AccountFields.passwordButton
    private let websiteField = AccountFields.websiteField
    
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
    }
    
    func configureSubviews() {
        view.addSubview(nameField)
        view.addSubview(emailOrUsernameField)
        view.addSubview(passwordField)
        view.addSubview(passwordButton)
        view.addSubview(websiteField)
    }
    
    func configureFields() {
        AccountFields.addBottomLineFor(field: nameField)
        AccountFields.addBottomLineFor(field: emailOrUsernameField)
        AccountFields.addBottomLineFor(field: websiteField)
        
        passwordButton.addTarget(self, action: #selector(tapOnPasswordButton), for: .touchUpInside)
        
        setupFieldConstraints()
    }
    
    func setupFieldConstraints() {
        nameField.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         leading: view.leadingAnchor,
                         bottom: emailOrUsernameField.topAnchor,
                         trailing: view.trailingAnchor,
                         padding: UIEdgeInsets(top: 10, left: 16, bottom: 1, right: 16),
                         size: CGSize(width: 0, height: 55))
        
        emailOrUsernameField.anchor(top: nil,
                                    leading: view.leadingAnchor,
                                    bottom: passwordField.topAnchor,
                                    trailing: view.trailingAnchor,
                                    padding: UIEdgeInsets(top: 0, left: 16, bottom: 1, right: 16),
                                    size: CGSize(width: 0, height: 55))
        
        passwordField.anchor(top: nil,
                             leading: view.leadingAnchor,
                             bottom: websiteField.topAnchor,
                             trailing: view.trailingAnchor,
                             padding: UIEdgeInsets(top: 0, left: 16, bottom: 41, right: 16),
                             size: CGSize(width: 0, height: 55))
        
        passwordButton.anchor(top: passwordField.topAnchor,
                              leading: nil,
                              bottom: passwordField.bottomAnchor,
                              trailing: passwordField.trailingAnchor,
                              padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
        websiteField.anchor(top: nil,
                            leading: view.leadingAnchor,
                            bottom: nil,
                            trailing: view.trailingAnchor,
                            padding: UIEdgeInsets(top: 0, left: 16, bottom: 1, right: 16),
                            size: CGSize(width: 0, height: 55))
    }
    
    @objc func tapOnCancel() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func tapOnSave() {
        guard let title = nameField.text,
              let emailOrUsername = emailOrUsernameField.text
        else { return }
        
        let newAccount = Account(title: title,
                                 emailOrUsername: emailOrUsername,
                                 password: passwordField.text ?? "",
                                 website: websiteField.text ?? "",
                                 createdAt: dateFormatter.string(from: Date()),
                                 updatedAt: "")
        
        delegate?.addAccount(account: newAccount)
        
        navigationController?.popViewController(animated: true)
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
