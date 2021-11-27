//
//  SettingsTableViewCell.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 09.11.2021.
//

import UIKit

class SettingsTableViewCell: BaseSettingsTableViewCell {
    
    static let identifier = "SettingsTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .disclosureIndicator
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = CGRect(x: 20,
                             y: 0,
                             width: contentView.frame.size.width - 20,
                             height: contentView.frame.size.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        label.text = nil
    }
    
    public func configure(with model: SettingsOption) {
        label.text = model.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
