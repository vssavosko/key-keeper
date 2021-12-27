//
//  AuthorizationViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 13.10.2021.
//

import UIKit
import LocalAuthentication
import SwiftKeychainWrapper
import Localize_Swift

class AuthorizationViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .init(imageLiteralResourceName: "fingerprint_logo")
        imageView.contentMode = .center
        
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    private let passwordField: FormField = {
        let field = FormField(textColor: .white, fieldType: .password)
        
        field.translatesAutoresizingMaskIntoConstraints = false
        field.attributedPlaceholder = NSAttributedString(string: "Master password".localized(),
                                                         attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray])
        field.returnKeyType = .continue
        
        field.addBottomLine(backgroundColor: .black, lineColor: .white)
        
        field.addTarget(self, action: #selector(tapOnContinueButton), for: .primaryActionTriggered)
        
        return field
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        configureSubviews()
        setupElementConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: Keys.biometricSwitchState) {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authorize with biometrics".localized()
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                    [weak self] (success, error) in DispatchQueue.main.async {
                        guard success, error == nil else {
                            self?.presentAlert(title: "Failed to authenticate".localized(),
                                               message: "Please try again".localized())
                            
                            return
                        }
                        
                        self?.dismiss(animated: true)
                    }
                }
            } else {
                self.presentAlert(title: "Unavailable feature".localized(),
                                  message: "Authorization using biometric is not possible. Enable this feature in Settings -> KeyKeeper".localized())
            }
        }
    }
    
    private func configureSubviews() {
        view.addSubview(imageView)
        view.addSubview(passwordField)
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
    
    @objc private func tapOnContinueButton() {
        guard let enteredPassword = passwordField.text else { return }
        
        let masterPassword = KeychainWrapper.standard.string(forKey: Keys.masterPassword)
        
        if enteredPassword == masterPassword {
            dismiss(animated: true)
        } else {
            self.triggerNotification(text: "Invalid password".localized())
        }
    }
    
}
