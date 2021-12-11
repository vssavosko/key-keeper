//
//  MasterPasswordViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 08.10.2021.
//

import UIKit
import LocalAuthentication
import Localize_Swift

class MasterPasswordViewController: UIViewController {
    
    var completion: ((String) -> Void)!
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "First, create a Master Password".localized()
        label.numberOfLines = 0
        
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemBlue
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "For your safety, we do not keep copies of your password".localized()
        label.numberOfLines = 0
        
        return label
    }()
    private let passwordField: TextFieldWithPadding = {
        let field = TextFieldWithPadding()
        
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textColor = .black
        field.attributedPlaceholder = NSAttributedString(string: "Enter strong master password".localized(),
                                                         attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray])
        field.textContentType = .password
        field.isSecureTextEntry = true
        
        return field
    }()
    private let repeatPasswordField: TextFieldWithPadding = {
        let field = TextFieldWithPadding()
        
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textColor = .black
        field.attributedPlaceholder = NSAttributedString(string: "Repeat master password".localized(),
                                                         attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray])
        field.textContentType = .password
        field.isSecureTextEntry = true
        
        return field
    }()
    private let saveButton: RoundButton = {
        let button = RoundButton(text: "Save".localized())
        
        button.addTarget(self, action: #selector(tapOnSaveButton), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureSubviews()
        configureElements()
    }
    
    private func configureSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(passwordField)
        view.addSubview(repeatPasswordField)
        view.addSubview(saveButton)
    }
    
    private func configureElements() {
        BottomLine.generateFor(element: passwordField, backgroundColor: .white, lineColor: .lightGray)
        BottomLine.generateFor(element: repeatPasswordField, backgroundColor: .white, lineColor: .lightGray)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.anchor(top: view.topAnchor,
                          leading: view.leadingAnchor,
                          bottom: descriptionLabel.topAnchor,
                          trailing: view.trailingAnchor,
                          padding: UIEdgeInsets(top: 40, left: 40, bottom: 20, right: 40))
        
        descriptionLabel.anchor(top: nil,
                                leading: view.leadingAnchor,
                                bottom: passwordField.topAnchor,
                                trailing: view.trailingAnchor,
                                padding: UIEdgeInsets(top: 0, left: 40, bottom: 20, right: 40))
        
        passwordField.anchor(top: nil,
                             leading: view.leadingAnchor,
                             bottom: repeatPasswordField.topAnchor,
                             trailing: view.trailingAnchor,
                             padding: UIEdgeInsets(top: 0, left: 40, bottom: 20, right: 40))
        
        repeatPasswordField.anchor(top: nil,
                                   leading: view.leadingAnchor,
                                   bottom: saveButton.topAnchor,
                                   trailing: view.trailingAnchor,
                                   padding: UIEdgeInsets(top: 0, left: 40, bottom: 20, right: 40))
        
        saveButton.anchor(top: nil,
                          leading: view.leadingAnchor,
                          bottom: nil,
                          trailing: view.trailingAnchor,
                          padding: UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40),
                          size: CGSize(width: 0, height: 50))
    }
    
    @objc private func tapOnSaveButton() {
        let context = LAContext()
        var error: NSError?
        
        guard let password = passwordField.text,
              let repeatPassword = repeatPasswordField.text
        else { return }
        
        guard !password.isEmpty && !repeatPassword.isEmpty else {
            return self.triggerNotification(text: "Fill in the fields".localized())
        }
        
        guard password == repeatPassword else {
            return self.triggerNotification(text: "Passwords do not match".localized())
        }
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authorize with biometrics".localized()
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] (success, error) in DispatchQueue.main.async {
                    if success && error == nil {
                        UserDefaults.standard.set(true, forKey: Keys.biometricSwitchState)
                    }
                    
                    self?.dismiss(animated: true)
                    
                    self?.completion(password)
                }
            }
        }
    }
    
}
