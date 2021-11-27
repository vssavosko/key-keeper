//
//  BaseChecklistTableViewCell.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 17.11.2021.
//

import UIKit

class ChecklistTableViewCell: UITableViewCell {
    
    static let identifier = "ChecklistTableViewCell"
    
    public let label = Generator.generateLabel(textColor: .label, numberOfLines: 1)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
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
    
    public func configure(with option: ChecklistOption) {
        label.text = option.title
        
        self.accessoryType = option.isChecked ? .checkmark : .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
