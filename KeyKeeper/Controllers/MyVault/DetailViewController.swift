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
    
    let dateFormatter = DateFormatter.configure()
    
    var delegate: UpdateAccountDelegate?
    var indexRow: Int?
    
    var accountData: Account!
    
    private let createdLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.text = ""
        label.textAlignment = .center
        
        return label
    }()
    private let lastModifiedLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.text = ""
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var dateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [createdLabel, lastModifiedLabel])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstStackView.addArrangedSubview(generatePasswordButton)
        secondStackView.addArrangedSubview(dateStackView)
        
        configureFields()
        configureLabels()
    }
    
    func set(account: Account) {
        accountData = account
    }
    
    override func configureNavigationBar() {
        navigationItem.title = accountData.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit".localized(),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(tapOnEdit))
    }
    
    override func configureFields() {
        super.configureFields()
        
        if accountData.website.isEmpty {
            websiteStackView.isHidden = true
        }
        
        if accountData.notes.isEmpty {
            notesStackView.isHidden = true
        }
        
        loginField.text = accountData.login
        passwordField.text = accountData.password
        websiteField.text = accountData.website
        notesTextView.text = accountData.notes
        
        loginField.isEnabled = false
        passwordField.isEnabled = false
        websiteField.isEnabled = false
        notesTextView.isEditable = false
        
        if !accountData.notes.isEmpty {
            Generator.generateBottomLineFor(element: websiteStackView)
        }
    }
    
    func configureLabels() {
        createdLabel.isHidden = accountData.createdAt == ""
        lastModifiedLabel.isHidden = accountData.updatedAt == ""
        
        createdLabel.text = "\("Created".localized()): \(DateFormatter.changeDateFormatFor(date: accountData.createdAt))"
        lastModifiedLabel.text = "\("Last modified".localized()): \(DateFormatter.changeDateFormatFor(date: accountData.updatedAt))"
        
        lastModifiedLabel.anchor(top: createdLabel.bottomAnchor,
                                 leading: nil,
                                 bottom: nil,
                                 trailing: nil,
                                 padding: UIEdgeInsets(top: 3, left: 0, bottom: 0, right: 0))
    }
    
    func updateViewControllerData(title: String, login: String, password: String, website: String, note: String) {
        self.accountData.title = title
        self.accountData.login = login
        self.accountData.password = password
        self.accountData.website = website
        self.accountData.notes = note
        
        navigationItem.title = title
        loginField.text = login
        passwordField.text = password
        websiteField.text = website
        notesTextView.text = note
        
        if websiteStackView.isHidden == false && accountData.website.isEmpty {
            websiteStackView.isHidden = true
        } else {
            websiteStackView.isHidden = false
        }
        
        if notesStackView.isHidden == false && accountData.notes.isEmpty {
            notesStackView.isHidden = true
        } else {
            notesStackView.isHidden = false
        }
    }
    
    @objc func tapOnEdit() {
        let editVC = EditViewController()
        
        editVC.delegate = self
        
        editVC.set(account: accountData)
        
        editVC.completion = { [weak self] (title: String, login: String, password: String, website: String, note: String) in
            guard
                let dateFormatter = self?.dateFormatter,
                let indexRow = self?.indexRow,
                let createdAt = self?.accountData.createdAt,
                let lastModifiedLabel = self?.lastModifiedLabel,
                let updateViewControllerData = self?.updateViewControllerData
            else { return }
            
            updateViewControllerData(title, login, password, website, note)
            
            let updatedAccount = Account(title: title,
                                         login: login,
                                         password: password,
                                         website: website,
                                         notes: note,
                                         createdAt: createdAt,
                                         updatedAt: dateFormatter.string(from: Date()))
            
            lastModifiedLabel.text = "\("Last modified".localized()): \(DateFormatter.changeDateFormatFor(date: updatedAccount.updatedAt))"
            
            if lastModifiedLabel.isHidden {
                lastModifiedLabel.isHidden = false
            }
            
            self!.delegate?.updateAccount(account: updatedAccount, indexRow: indexRow)
        }
        
        navigationController?.pushViewController(editVC, animated: true)
    }
    
}
