//
//  CustomTextField.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 19.08.2021.
//

import UIKit

class TextFieldWithPadding: UITextField {
    
    private let textPadding = UIEdgeInsets(
        top: 5,
        left: 0,
        bottom: 10,
        right: 0
    )
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        
        return rect.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        
        return rect.inset(by: textPadding)
    }
    
}
