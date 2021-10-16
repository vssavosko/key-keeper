//
//  AuthorizationViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 13.10.2021.
//

import UIKit
import LocalAuthentication
import SwiftKeychainWrapper

class AuthorizationViewController: UIViewController {
    
    private let imageView = Generator.generateImageView(image: UIImage(imageLiteralResourceName: "fingerprint_logo"))
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
    
    override func viewDidAppear(_ animated: Bool) {
        loginUsingBiometricData()
    }
    
    private func configureSubviews() {
        view.addSubview(imageView)
        view.addSubview(passwordField)
    }
    
    private func configureElements() {
        Generator.generateBottomLineFor(field: passwordField,
                                        backgroundColor: .black,
                                        lineColor: .white)
        
        passwordField.returnKeyType = .continue
        passwordField.addTarget(self, action: #selector(tapOnContinueButton), for: .primaryActionTriggered)
        
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
                             padding: UIEdgeInsets(top: 0, left: 30, bottom: 40, right: 30))
    }
    
    private func loginUsingBiometricData() {
        let context = LAContext()
        var error: NSError? = nil
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authorize with Touch ID!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] (success, error) in
                DispatchQueue.main.async {
                    guard success, error == nil else {
                        //                        let alert = UIAlertController(title: "Failed to Authenticate",
                        //                                                      message: "Please try again.",
                        //                                                      preferredStyle: .alert)
                        //
                        //                        alert.addAction(UIAlertAction(title: "Dismiss",
                        //                                                      style: .cancel,
                        //                                                      handler: nil))
                        //
                        //                        self?.present(alert, animated: true)
                        
                        return
                    }
                    
                    self?.dismiss(animated: true)
                }
            }
        } else {
            let alert = UIAlertController(title: "Unavailable",
                                          message: "You can not use this feature",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Dismiss",
                                          style: .cancel,
                                          handler: nil))
            
            self.present(alert, animated: true)
        }
    }
    
    @objc private func tapOnContinueButton() {
        guard let enteredPassword = passwordField.text else { return }
        
        let masterPassword = KeychainWrapper.standard.string(forKey: Keys.masterPassword)
        
        if enteredPassword == masterPassword {
            dismiss(animated: true)
        } else {
            self.triggerNotification(view: view, text: "Invalid password!")
        }
    }
    
}
