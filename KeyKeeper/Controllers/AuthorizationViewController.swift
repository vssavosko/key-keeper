//
//  AuthorizationViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 13.10.2021.
//

import UIKit
import SwiftKeychainWrapper

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
    private let authorizationButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Go", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 25
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        configureSubviews()
        configureElements()
    }
    
    private func configureSubviews() {
        view.addSubview(imageView)
        view.addSubview(passwordField)
        view.addSubview(authorizationButton)
    }
    
    private func configureElements() {
        Generator.generateBottomLineFor(field: passwordField,
                                        backgroundColor: .black,
                                        lineColor: .white)
        
        authorizationButton.addTarget(self, action: #selector(tapOnButton), for: .touchUpInside)
        
        
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
                             bottom: authorizationButton.topAnchor,
                             trailing: view.trailingAnchor,
                             padding: UIEdgeInsets(top: 0, left: 30, bottom: 40, right: 30))
        
        authorizationButton.anchor(top: nil,
                                   leading: view.leadingAnchor,
                                   bottom: nil,
                                   trailing: view.trailingAnchor,
                                   padding: UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30),
                                   size: CGSize(width: 0, height: 50))
    }
    
    private func triggerErrorNotification(errorText: String) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) { [weak self] in
            let clipboardNotification = ClipboardNotification()
            
            clipboardNotification.messageLabel.text = errorText
            
            self!.view.addSubview(clipboardNotification)
        }
    }
    
    @objc private func tapOnButton() {
        guard let enteredPassword = passwordField.text else { return }
        
        let masterPassword = KeychainWrapper.standard.string(forKey: Keys.masterPassword)
        
        if enteredPassword == masterPassword {
            dismiss(animated: true)
        } else {
            triggerErrorNotification(errorText: "Invalid password!")
        }
    }
    
}
