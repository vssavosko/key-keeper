//
//  Generator.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 15.09.2021.
//

import UIKit
import Localize_Swift

class Generator {
    
    static func generateImageView(image: UIImage? = nil,
                                  tintColor: UIColor? = nil,
                                  contentMode: UIView.ContentMode? = .center) -> UIImageView {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        if let image = image {
            imageView.image = image
        }
        
        if let tintColor = tintColor {
            imageView.tintColor = tintColor
        }
        
        if let contentMode = contentMode {
            imageView.contentMode = contentMode
        }
        
        imageView.layer.masksToBounds = true
        
        return imageView
    }
    
    static func generateLabel(text: String? = nil,
                              textAlignment: NSTextAlignment = .left,
                              textColor: UIColor = .secondaryLabel,
                              font: UIFont = .systemFont(ofSize: 15, weight: .medium),
                              numberOfLines: Int = 1) -> UILabel {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        if let text = text {
            label.text = text
        }
        
        label.textAlignment = textAlignment
        label.textColor = textColor
        label.font = font
        label.numberOfLines = numberOfLines
        
        return label
    }
    
    static func generateField(contentType: FieldContentTypeEnum? = .none,
                              textColor: UIColor = .label,
                              placeholder: String? = nil,
                              placeholderColor: UIColor? = nil) -> TextFieldWithPadding {
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
        
        field.font = .systemFont(ofSize: 17, weight: .regular)
        field.textColor = textColor
        
        if let placeholder = placeholder {
            field.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                             attributes: placeholderColor != nil ? [NSAttributedString.Key.foregroundColor : placeholderColor!] : nil)
        }
        
        field.borderStyle = .none
        
        return field
    }
    
    static func generateStackView(subviews: [UIView],
                                  axis: NSLayoutConstraint.Axis = .horizontal,
                                  alignment: UIStackView.Alignment = .center,
                                  spacing: CGFloat? = nil ) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: subviews)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.distribution = .equalSpacing
        stackView.alignment = alignment
        
        if let spacing = spacing {
            stackView.spacing = spacing
        }
        
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
    
    static var passwordButton: UIButton {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        
        return button
    }
    
    static var generatePasswordButton: UIButton {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Generate password".localized(), for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        
        return button
    }
    
    static func roundButton(text: String) -> UIButton {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(text, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        
        return button
    }
    
}
