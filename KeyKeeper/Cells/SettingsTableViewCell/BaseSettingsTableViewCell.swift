//
//  SettingsBaseTableViewCell.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 12.11.2021.
//

import UIKit

class BaseSettingsTableViewCell: UITableViewCell {
    
    internal let label: UILabel = {
        let label = UILabel()
        
        label.textColor = .label
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = 1
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
        
        configureContentView()
    }
    
    private func configureContentView() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

