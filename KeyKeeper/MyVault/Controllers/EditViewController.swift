//
//  EditViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 17.08.2021.
//

import UIKit

class EditViewController: UIViewController {
    
    var delegate: DetailViewController?
    
    var accountTitle: String?
    var emailOrUsername: String?
    var password: String?
    var website: String?
    var completion: ((String, String, String, String) -> Void)?
    
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
    
    func configureNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
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
        nameField.text = accountTitle
        emailOrUsernameField.text = emailOrUsername
        passwordField.text = password
        websiteField.text = website
        
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
                         padding: UIEdgeInsets(top: 0, left: 16, bottom: 1, right: 16),
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
                            padding: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16),
                            size: CGSize(width: 0, height: 55))
    }
    
    @objc func tapOnPasswordButton(sender: UIButton!) {
        passwordField.isSecureTextEntry = !passwordField.isSecureTextEntry
        
        if passwordField.isSecureTextEntry {
            passwordButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        } else {
            passwordButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        }
    }
    
    @objc func tapOnCancel() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func tapOnSave() {
        guard
            let title = nameField.text,
            let emailOrUsername = emailOrUsernameField.text,
            let password = passwordField.text,
            let website = websiteField.text,
            let completion = completion
        else { return }
        
        completion(title, emailOrUsername, password, website)
        
        navigationController?.popViewController(animated: true)
    }
    
}
