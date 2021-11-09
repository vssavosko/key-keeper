//
//  SwitchTableViewCell.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 09.11.2021.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    
    static let identifier = "SwitchTableViewCell"
    
    var completion: (() -> Void)?
    
    private let iconContainer: UIView = {
        let view = UIView()
        
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 1
        
        return label
    }()
    
    private let mySwtich: UISwitch = {
        let mySwitch = UISwitch()
        
        mySwitch.onTintColor = .systemBlue
        
        return mySwitch
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        contentView.addSubview(label)
        contentView.addSubview(mySwtich)
        
        contentView.clipsToBounds = true
        
        accessoryType = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size  = contentView.frame.size.height - 12
        
        iconContainer.frame = CGRect(x: 15,
                                     y: 6,
                                     width: size,
                                     height: size)
        
        let imageSize: CGFloat = size/1.5
        
        iconImageView.frame = CGRect(x: (size - imageSize) / 2,
                                     y: (size - imageSize) / 2,
                                     width: imageSize,
                                     height: imageSize)
        
        mySwtich.sizeToFit()
        mySwtich.frame = CGRect(x: contentView.frame.size.width - mySwtich.frame.size.width - 20,
                                y: (contentView.frame.size.height - mySwtich.frame.size.height) / 2,
                                width: mySwtich.frame.size.width,
                                height: mySwtich.frame.size.height)
        
        label.frame = CGRect(x: iconContainer.frame.size.width + 25,
                             y: 0,
                             width: contentView.frame.size.width - 20 - iconContainer.frame.size.width,
                             height: contentView.frame.size.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        iconImageView.image = nil
        label.text = nil
        iconContainer.backgroundColor = nil
        mySwtich.isOn = false
    }
    
    public func configure(with model: SettingsSwitchOption) {
        label.text = model.title
        iconImageView.image = model.icon
        iconContainer.backgroundColor = model.iconBackgroundColor
        mySwtich.isOn = model.isOn
        
        mySwtich.addTarget(self, action: #selector(test), for: .valueChanged)
    }
    
    @objc func test() {
        completion!()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

