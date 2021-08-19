//
//  FieldsGenerator.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 05.08.2021.
//

import UIKit

class FieldsGenerator {
    
    static var passwordButton: UIButton {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        
        return button
    }
    
    static func createLabel(text: String) -> UILabel {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(16)
        label.textColor = .systemGray
        
        label.text = text
        
        return label
    }
    static func createField(isPassword: Bool = false, placeholder: String) -> TextFieldWithPadding {
        let field = TextFieldWithPadding()
        
        field.translatesAutoresizingMaskIntoConstraints = false
        
        if isPassword {
            field.isSecureTextEntry = true
        }
        
        field.placeholder = placeholder
        field.borderStyle = .none
        
        return field
    }
    static func addBottomLineFor(field: UITextField) {
        field.layer.backgroundColor = UIColor.systemBackground.cgColor
        field.layer.masksToBounds = false
        field.layer.shadowColor = UIColor.systemGray5.cgColor
        field.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        field.layer.shadowOpacity = 1.0
        field.layer.shadowRadius = 0.0
    }
    
}
