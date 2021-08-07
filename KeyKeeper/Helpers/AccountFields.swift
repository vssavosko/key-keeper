//
//  AccountFields.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 05.08.2021.
//

import UIKit

class AccountFields {
    
    static var nameField: UITextField {
        let field = UITextField()
        
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Name"
        field.borderStyle = .none
        
        return field
    }
    static var emailOrUsernameField: UITextField {
        let field = UITextField()
        
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Email or username"
        field.borderStyle = .none
        
        return field
    }
    static var passwordField: UITextField {
        let field = UITextField()
        
        field.translatesAutoresizingMaskIntoConstraints = false
        field.isSecureTextEntry = true
        field.placeholder = "Password"
        field.borderStyle = .none
        
        return field
    }
    static var passwordButton: UIButton {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        
        return button
    }
    static var websiteField: UITextField {
        let field = UITextField()
        
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Website"
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
