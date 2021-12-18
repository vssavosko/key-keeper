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
    
    private let cellSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        
        uiSwitch.addTarget(self, action: #selector(triggerSwitch), for: .valueChanged)
        
        return uiSwitch
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cellSwitch)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = CGRect(x: 20,
                             y: 0,
                             width: contentView.frame.size.width - 20,
                             height: contentView.frame.size.height)
        
        cellSwitch.sizeToFit()
        cellSwitch.frame = CGRect(x: contentView.frame.size.width - cellSwitch.frame.size.width - 20,
                                  y: (contentView.frame.size.height - cellSwitch.frame.size.height) / 2,
                                  width: cellSwitch.frame.size.width,
                                  height: cellSwitch.frame.size.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        label.text = nil
        cellSwitch.isOn = false
    }
    
    public func configure(with model: SettingsSwitchOption) {
        label.text = model.title
        cellSwitch.isOn = model.isOn
        
        cellSwitch.addTarget(self, action: #selector(triggerSwitch), for: .valueChanged)
    }
    
    @objc private func triggerSwitch() {
        guard let completion = completion else { return }
        
        completion()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

