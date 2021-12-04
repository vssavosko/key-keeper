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

class CreateViewController: BaseMyVaultViewController {
    
    let dateFormatter = DateFormatter.configure()
    
    var delegate: AddAccountDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstStackView.insertArrangedSubview(titleStackView, at: 0)
    }
    
    override func configureNavigationBar() {
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
    
    override func configureFields() {
        super.configureFields()
        
        titleField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        loginField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        generatePasswordButton.addTarget(self, action: #selector(tapOnGeneratorButton), for: .touchUpInside)
        
        passwordButton.isEnabled = false
    }
    
    @objc func tapOnCancel() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func tapOnSave() {
        guard let title = titleField.text,
              let login = loginField.text,
              let password = passwordField.text
        else { return }
        
        let newAccount = Account(title: title,
                                 login: login,
                                 password: password,
                                 website: websiteField.text ?? "",
                                 notes: notesTextView.text ?? "",
                                 createdAt: dateFormatter.string(from: Date()),
                                 updatedAt: "")
        
        delegate?.addAccount(account: newAccount)
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc func textFieldDidChange() {
        if !titleField.hasText || !loginField.hasText || !passwordField.hasText {
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
    
    @objc func tapOnGeneratorButton() {
        let generatorVC = GeneratorViewController()
        
        generatorVC.completion = { [weak self] (password: String) in
            self?.passwordField.text = password
            
            self?.textFieldDidChange()
        }
        
        navigationController?.pushViewController(generatorVC, animated: true)
    }
    
}
