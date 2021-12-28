//
//  DetailViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 05.08.2021.
//

import UIKit
import Localize_Swift

protocol UpdateAccountDelegate {
    
    func updateAccount(account: Account, indexRow: Int)
    
}

class DetailViewController: BaseMyVaultViewController {
    
    private let dateFormatter = DateFormatter.configure()
    
    var delegate: UpdateAccountDelegate?
    var accountData: Account!
    var indexRow: Int?
    
    private let createdLabel: UniversalLabel = {
        let label = UniversalLabel(font: .systemFont(ofSize: 13, weight: .regular))
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    private let lastModifiedLabel: UniversalLabel = {
        let label = UniversalLabel(font: .systemFont(ofSize: 13, weight: .regular))
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    private lazy var dateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [createdLabel, lastModifiedLabel])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 5.0
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        additionalInfoStackView.addArrangedSubview(dateStackView)
        
        configureElements()
    }
    
    public func set(account: Account) {
        accountData = account
    }
    
    override func configureNavigationBar() {
        navigationItem.title = accountData.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit".localized(),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(tapOnEdit))
    }
    
    override func configureElements() {
        super.configureElements()
        
        oneIconConstraint?.isActive = false
        twoIconConstraint?.isActive = true
        
        loginField.isEnabled = false
        passwordField.isEnabled = false
        websiteField.isEnabled = false
        notesTextView.isEditable = false
        
        copyLoginButton.isHidden = false
        copyPasswordButton.isHidden = false
        generatePasswordButton.isHidden = true
        createdLabel.isHidden = accountData.createdAt == ""
        lastModifiedLabel.isHidden = accountData.updatedAt == ""
        
        if accountData.website.isEmpty {
            websiteStackView.isHidden = true
        }
        
        if accountData.notes.isEmpty {
            websiteStackView.layer.backgroundColor = .none
        }
        
        if accountData.notes.isEmpty || accountData.notes == notePlaceholder {
            notesStackView.isHidden = true
        }
        
        loginField.text = accountData.login
        passwordField.text = accountData.password
        websiteField.text = accountData.website
        notesTextView.text = accountData.notes
        createdLabel.text = "\("Created".localized()): \(DateFormatter.changeDateFormatFor(date: accountData.createdAt))"
        lastModifiedLabel.text = "\("Last modified".localized()): \(DateFormatter.changeDateFormatFor(date: accountData.updatedAt))"
        
        copyLoginButton.addTarget(self, action: #selector(tapOnCopyLoginButton), for: .touchUpInside)
        copyPasswordButton.addTarget(self, action: #selector(tapOnCopyPasswordButton), for: .touchUpInside)
    }
    
    private func updateViewControllerData(newAccountData: Account) {
        accountData.title = newAccountData.title
        accountData.login = newAccountData.login
        accountData.password = newAccountData.password
        accountData.website = newAccountData.website
        accountData.notes = newAccountData.notes
        
        navigationItem.title = newAccountData.title
        loginField.text = newAccountData.login
        passwordField.text = newAccountData.password
        websiteField.text = newAccountData.website
        notesTextView.text = newAccountData.notes
        lastModifiedLabel.text = "\("Last modified".localized()): \(DateFormatter.changeDateFormatFor(date: newAccountData.updatedAt))"
        
        if newAccountData.website.isEmpty {
            websiteStackView.isHidden = true
        } else {
            websiteStackView.isHidden = false
        }
        
        if newAccountData.notes.isEmpty || newAccountData.notes == notePlaceholder {
            notesStackView.isHidden = true
            
            websiteStackView.layer.backgroundColor = .none
        } else {
            notesStackView.isHidden = false
            
            websiteStackView.layer.backgroundColor = UIColor.systemBackground.cgColor
        }
        
        if lastModifiedLabel.isHidden {
            lastModifiedLabel.isHidden = false
        }
    }
    
    private func copyValueOf(field: UITextField, text: String? = nil) {
        guard let value = field.text else { return }
        
        self.triggerNotification(text: text) {
            UIPasteboard.general.string = value
        }
    }
    
    @objc private func tapOnEdit() {
        let editVC = EditViewController()
        
        editVC.delegate = self
        
        editVC.set(account: accountData)
        
        editVC.completion = { [weak self] (newAccountData: Account) in
            guard let indexRow = self?.indexRow else { return }
            
            let updatedAccount = Account(title: newAccountData.title,
                                         login: newAccountData.login,
                                         password: newAccountData.password,
                                         website: newAccountData.website,
                                         notes: newAccountData.notes,
                                         createdAt: self?.accountData.createdAt ?? "",
                                         updatedAt: self?.dateFormatter.string(from: Date()) ?? "")
            
            self?.updateViewControllerData(newAccountData: updatedAccount)
            
            self!.delegate?.updateAccount(account: updatedAccount, indexRow: indexRow)
        }
        
        navigationController?.pushViewController(editVC, animated: true)
    }
    
    @objc private func tapOnCopyLoginButton() {
        copyValueOf(field: loginField, text: "Username copied".localized())
    }
    
    @objc private func tapOnCopyPasswordButton() {
        copyValueOf(field: passwordField)
    }
    
}
