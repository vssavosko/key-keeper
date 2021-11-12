//
//  SettingsBaseTableViewCell.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 12.11.2021.
//

import UIKit

class BaseSettingsTableViewCell: UITableViewCell {
    
//    internal let iconContainer: UIView = {
//        let view = UIView()
//
//        view.clipsToBounds = true
//        view.layer.cornerRadius = 8
//        view.layer.masksToBounds = true
//
//        return view
//    }()
    
//    internal let iconImageView = Generator.generateImageView(tintColor: .white, contentMode: .scaleAspectFit)
    
    internal let label = Generator.generateLabel(textColor: .label, numberOfLines: 1)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureSubviews()
        configureContentView()
    }
    
    private func configureSubviews() {
//        contentView.addSubview(iconContainer)
//        iconContainer.addSubview(iconImageView)
        contentView.addSubview(label)
    }
    
    private func configureContentView() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

