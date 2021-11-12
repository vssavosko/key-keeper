//
//  SettingsTableViewCell.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 09.11.2021.
//

import UIKit

// - TODO: Think about the image in cell

class SettingsTableViewCell: BaseSettingsTableViewCell {
    
    static let identifier = "SettingsTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .disclosureIndicator
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //        let size = contentView.frame.size.height - 12
        
        //        iconContainer.frame = CGRect(x: 15,
        //                                     y: 6,
        //                                     width: size,
        //                                     height: size)
        //
        //        let imageSize: CGFloat = size / 1.5
        //
        //        iconImageView.frame = CGRect(x: (size - imageSize) / 2,
        //                                     y: (size - imageSize) / 2,
        //                                     width: imageSize,
        //                                     height: imageSize)
        
        label.frame = CGRect(x: 20,
                             y: 0,
                             width: contentView.frame.size.width - 20,
                             height: contentView.frame.size.height)
        
        //        label.frame = CGRect(x: iconContainer.frame.size.width + 25,
        //                             y: 0,
        //                             width: contentView.frame.size.width - 20 - iconContainer.frame.size.width,
        //                             height: contentView.frame.size.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        //        iconImageView.image = nil
        label.text = nil
        //        iconContainer.backgroundColor = nil
    }
    
    public func configure(with model: SettingsOption) {
        label.text = model.title
        //        iconImageView.image = model.icon
        //        iconContainer.backgroundColor = model.iconBackgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
