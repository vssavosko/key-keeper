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
        label.font = .systemFont(ofSize: 17, weight: .medium)
        
        return label
    }()
    private let accountLogin: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .systemGray
        
        return label
    }()
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [accountTitle, accountLogin])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureElements()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        accountTitle.text = nil
        accountLogin.text = nil
    }
    
    public func configure(account: Account) {
        accountTitle.text = account.title
        accountLogin.text = account.login
    }
    
    private func configureElements() {
        addSubview(labelsStackView)
        
        labelsStackView.anchor(top: contentView.topAnchor,
                               leading: leadingAnchor,
                               bottom: contentView.bottomAnchor,
                               trailing: trailingAnchor,
                               padding: UIEdgeInsets(top: 7, left: 20, bottom: 7, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
