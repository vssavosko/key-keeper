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
    var completion: ((Account) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accountDataStackView.insertArrangedSubview(titleStackView, at: 0)
    }
    
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
    
    override func configureElements() {
        titleField.text = accountData.title
        loginField.text = accountData.login
        passwordField.text = accountData.password
        websiteField.text = accountData.website
        notesTextView.text = accountData.notes
        
        titleField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        loginField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        generatePasswordButton.addTarget(self, action: #selector(tapOnGeneratorButton), for: .touchUpInside)
        
        super.configureElements()
    }
    
    @objc private func tapOnCancel() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func tapOnSave() {
        guard
            let completion = completion,
            let title = titleField.text,
            let login = loginField.text,
            let password = passwordField.text,
            let website = websiteField.text,
            let notes = notesTextView.text
        else { return }
        
        completion(
            Account(
                title: title,
                login: login,
                password: password,
                website: website,
                notes: notes,
                createdAt: self.accountData.createdAt,
                updatedAt: self.accountData.updatedAt
            )
        )
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func textFieldDidChange() {
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
    
    @objc private func tapOnGeneratorButton() {
        let generatorVC = GeneratorViewController()
        
        generatorVC.completion = { [weak self] (password: String) in
            self?.passwordField.text = password
            
            self?.textFieldDidChange()
        }
        
        navigationController?.pushViewController(generatorVC, animated: true)
    }
    
}
