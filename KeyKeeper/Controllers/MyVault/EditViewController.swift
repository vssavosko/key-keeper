//
//  EditViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 17.08.2021.
//

import UIKit
import Localize_Swift

class EditViewController: BaseMyVaultViewController {
    
    var delegate: DetailViewController?
    
    var accountData: Account!
    var completion: ((String, String, String, String, String) -> Void)?
    
    func set(account: Account) {
        accountData = account
    }
    
    override func configureNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Edit".localized()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel".localized(),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(tapOnCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save".localized(),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(tapOnSave))
    }
    
    override func configureFields() {
        super.configureFields()
        
        titleField.text = accountData.title
        loginField.text = accountData.login
        passwordField.text = accountData.password
        websiteField.text = accountData.website
        notesTextView.text = accountData.notes
        
        titleField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        loginField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        generatePasswordButton.addTarget(self, action: #selector(tapOnGeneratorButton), for: .touchUpInside)
    }
    
    @objc func tapOnCancel() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func tapOnSave() {
        guard
            let title = titleField.text,
            let login = loginField.text,
            let password = passwordField.text,
            let website = websiteField.text,
            let note = notesTextView.text,
            let completion = completion
        else { return }
        
        completion(title, login, password, website, note)
        
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
