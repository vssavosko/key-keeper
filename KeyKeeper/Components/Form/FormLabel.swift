//
//  FormLabel.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 27.12.2021.
//

import UIKit
import Localize_Swift

class FormLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(font: UIFont? = .systemFont(ofSize: 15, weight: .medium),
         textColor: UIColor? = nil,
         text: String? = nil) {
        super.init(frame: .zero)
        
        if let text = text {
            self.text = text.localized()
        }
        
        self.textColor = textColor != nil ? textColor : .secondaryLabel
        self.font = font
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
