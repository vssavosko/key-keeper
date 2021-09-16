//
//  Generator.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 15.09.2021.
//

import UIKit

enum FieldContentType {
    
    case login
    case password
    case website
    
}

class Generator {
    
    static func generateLabel(text: String,
                              textAlignment: NSTextAlignment = .left,
                              font: UIFont = UIFont.systemFont(ofSize: 15, weight: .medium),
                              color: UIColor = .secondaryLabel) -> UILabel {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textAlignment = textAlignment
        label.textColor = color
        label.font = font
        
        return label
    }
    
    static func generateField(contentType: FieldContentType? = .none,
                              placeholder: String? = nil) -> TextFieldWithPadding {
        let field = TextFieldWithPadding()
        
        field.translatesAutoresizingMaskIntoConstraints = false
        
        switch contentType {
        case .login:
            field.textContentType = .username
            field.keyboardType = .emailAddress
            field.autocapitalizationType = .none
        case .password:
            field.textContentType = .password
            field.isSecureTextEntry = true
        case .website:
            field.textContentType = .URL
            field.keyboardType = .URL
            field.autocapitalizationType = .none
        default: break
        }
        
        field.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        field.placeholder = placeholder != nil ? placeholder : .none
        field.borderStyle = .none
        
        return field
    }
    
    static func generateStackView() -> UIStackView {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        
        return stackView
    }
    
    static func generateSwitch() -> UISwitch {
        let uiSwitch = UISwitch()
        
        uiSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        return uiSwitch
    }
    
    static func generateThumb(size: CGSize, backgroundColor: UIColor = UIColor.white) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(backgroundColor.cgColor)
        context?.setStrokeColor(UIColor.clear.cgColor)
        
        let bounds = CGRect(origin: .zero, size: size)
        
        context?.addEllipse(in: bounds)
        context?.drawPath(using: .fill)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image
    }
    
    static func generateBottomLineFor(field: UITextField) {
        field.layer.backgroundColor = UIColor.systemBackground.cgColor
        field.layer.masksToBounds = false
        field.layer.shadowColor = UIColor.systemGray5.cgColor
        field.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        field.layer.shadowOpacity = 1.0
        field.layer.shadowRadius = 0.0
    }
    
    static var passwordButton: UIButton {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        
        return button
    }
    
}