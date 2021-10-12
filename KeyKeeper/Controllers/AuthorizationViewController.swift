//
//  AuthorizationViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 13.10.2021.
//

import UIKit

class AuthorizationViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = #imageLiteral(resourceName: "fingerprint_logo")
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private let passwordField = Generator.generateField(contentType: .password,
                                                        textColor: .white,
                                                        placeholder: "Master password",
                                                        placeholderColor: .systemGray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        configureSubviews()
        configureElements()
    }
    
    private func configureSubviews() {
        view.addSubview(imageView)
        view.addSubview(passwordField)
    }
    
    private func configureElements() {
        Generator.generateBottomLineFor(field: passwordField, backgroundColor: .black, lineColor: .white)
        
        setupElementConstraints()
    }
    
    private func setupElementConstraints() {
        imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         leading: view.leadingAnchor,
                         bottom: passwordField.topAnchor,
                         trailing: view.trailingAnchor,
                         padding: UIEdgeInsets(top: 40, left: 0, bottom: 40, right: 0))
        
        passwordField.anchor(top: nil,
                             leading: view.leadingAnchor,
                             bottom: nil,
                             trailing: view.trailingAnchor,
                             padding: UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30))
    }
    
}
