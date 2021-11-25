//
//  CreateAccountViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 27.07.2021.
//

import UIKit
import Localize_Swift

protocol AddAccountDelegate {
    
    func addAccount(account: Account)
    
}

class CreateViewController: UIViewController {
    
    let dateFormatter = DateFormatter.configure()
    
    var delegate: AddAccountDelegate?
    
    private let nameLabel = Generator.generateLabel(text: "Name".localized())
    private let nameField = Generator.generateField(placeholder: "Pied Piper")
    private let loginLabel = Generator.generateLabel(text: "Email or username".localized())
    private let loginField = Generator.generateField(contentType: .login, placeholder: "richardhendricks@piedpiper.com")
    private let passwordLabel = Generator.generateLabel(text: "Password".localized())
    private let passwordField = Generator.generateField(contentType: .password, placeholder: "QwEr123Ty456")
    private let passwordButton = Generator.passwordButton
    private let generatePasswordButton = Generator.generatePasswordButton
    private let websiteLabel = Generator.generateLabel(text: "Website".localized())
    private let websiteField = Generator.generateField(contentType: .website, placeholder: "www.piedpiper.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureNavigationBar()
        configureSubviews()
        configureFields()
    }
    
    func configureNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Create".localized()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel".localized(),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(tapOnCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save".localized(),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(tapOnSave))
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
        view.addSubview(generatePasswordButton)
        view.addSubview(websiteLabel)
        view.addSubview(websiteField)
    }
    
    func configureFields() {
        Generator.generateBottomLineFor(element: nameField)
        Generator.generateBottomLineFor(element: loginField)
        Generator.generateBottomLineFor(element: websiteField)
        
        nameField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        loginField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordButton.addTarget(self, action: #selector(tapOnPasswordButton), for: .touchUpInside)
        generatePasswordButton.addTarget(self, action: #selector(tapOnGeneratorButton), for: .touchUpInside)
        
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
                             bottom: generatePasswordButton.topAnchor,
                             trailing: view.trailingAnchor,
                             padding: UIEdgeInsets(top: 0, left: 16, bottom: 11, right: 16))
        passwordButton.anchor(top: passwordField.topAnchor,
                              leading: nil,
                              bottom: passwordField.bottomAnchor,
                              trailing: passwordField.trailingAnchor,
                              padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
        generatePasswordButton.anchor(top: nil,
                                      leading: nil,
                                      bottom: websiteLabel.topAnchor,
                                      trailing: view.trailingAnchor,
                                      padding: UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 16))
        
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
    
    @objc func tapOnPasswordButton() {
        passwordField.isSecureTextEntry = !passwordField.isSecureTextEntry
        
        if passwordField.isSecureTextEntry {
            passwordButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        } else {
            passwordButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        }
    }
    
    @objc func tapOnGeneratorButton() {
        let generatorVC = GeneratorViewController()
        
        generatorVC.completion = { [weak self] (password: String) in
            self?.passwordField.text = password
            
            self?.textFieldDidChange()
        }
        
        navigationController?.pushViewController(generatorVC, animated: true)
    }
    
}
