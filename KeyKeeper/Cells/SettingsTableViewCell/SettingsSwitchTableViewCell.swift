//
//  SettingsSwitchTableViewCell.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 09.11.2021.
//

import UIKit

// - TODO: Think about the image in cell

class SettingsSwitchTableViewCell: BaseSettingsTableViewCell {
    
    static let identifier = "SettingsSwitchTableViewCell"
    
    public var completion: (() -> Void)?
    
    private let cellSwitch = Generator.generateSwitch()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cellSwitch)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //        let size  = contentView.frame.size.height - 12
        
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
        
        cellSwitch.sizeToFit()
        cellSwitch.frame = CGRect(x: contentView.frame.size.width - cellSwitch.frame.size.width - 20,
                                  y: (contentView.frame.size.height - cellSwitch.frame.size.height) / 2,
                                  width: cellSwitch.frame.size.width,
                                  height: cellSwitch.frame.size.height)
        
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
        cellSwitch.isOn = false
    }
    
    public func configure(with model: SettingsSwitchOption) {
        label.text = model.title
        //        iconImageView.image = model.icon
        //        iconContainer.backgroundColor = model.iconBackgroundColor
        cellSwitch.isOn = model.isOn
        
        cellSwitch.addTarget(self, action: #selector(triggerSwitch), for: .valueChanged)
    }
    
    @objc private func triggerSwitch() {
        completion!()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

