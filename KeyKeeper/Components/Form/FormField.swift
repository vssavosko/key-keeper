//
//  FormField.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 27.12.2021.
//

import UIKit

class FormField: TextFieldWithPadding {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(font: UIFont? = .systemFont(ofSize: 17, weight: .regular),
         textColor: UIColor? = nil,
         placeholder: String? = nil,
         fieldType: FieldContentTypeEnum? = nil) {
        super.init(frame: .zero)
        
        if let placeholder = placeholder {
            self.placeholder = placeholder
        }
        
        autocapitalizationType = .none
        
        self.font = font
        self.textColor = textColor != nil ? textColor : .label
        
        switch fieldType {
        case .login:
            textContentType = .username
            keyboardType = .emailAddress
        case .password:
            textContentType = .password
            isSecureTextEntry = true
        case .website:
            textContentType = .URL
            keyboardType = .URL
        case .none:
            break
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
