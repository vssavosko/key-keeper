//
//  TableViewCell.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 25.07.2021.
//

import UIKit

class MyVaultCell: UITableViewCell {
    
    static let identifier = "MyVaultCell"
    
    private let accountTitle: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        
        return label
    }()
    private let accountEmailOrUsername: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .systemGray
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupStackView()
    }
    
    func set(account: Account) {
        accountTitle.text = account.title
        accountEmailOrUsername.text = account.emailOrUsername
    }
    
    func setupLabels() {
        addSubview(accountTitle)
        addSubview(accountEmailOrUsername)
        
        accountTitle.anchor(top: topAnchor,
                            leading: leadingAnchor,
                            bottom: accountEmailOrUsername.topAnchor,
                            trailing: trailingAnchor)
        accountEmailOrUsername.anchor(top: accountTitle.bottomAnchor,
                                      leading: leadingAnchor,
                                      bottom: bottomAnchor,
                                      trailing: trailingAnchor)
    }
    
    func setupStackView() {
        setupLabels()
        
        let stackView = UIStackView(arrangedSubviews: [accountTitle, accountEmailOrUsername])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        
        stackView.anchor(top: contentView.topAnchor,
                         leading: leadingAnchor,
                         bottom: contentView.bottomAnchor,
                         trailing: trailingAnchor,
                         padding: UIEdgeInsets(top: 7, left: 20, bottom: 7, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
