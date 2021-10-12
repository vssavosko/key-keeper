//
//  MasterPasswordViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 08.10.2021.
//

import UIKit

class MasterPasswordViewController: UIViewController {
    
    var completion: ((String) -> Void)!
    
    private let titleLabel = Generator.generateLabel(text: "First, create a Master Password",
                                                     textColor: .black,
                                                     font: .systemFont(ofSize: 22, weight: .semibold),
                                                     numberOfLines: 0)
    private let descriptionLabel = Generator.generateLabel(text: "For your safety, we do not keep copies of",
                                                           textColor: .systemBlue,
                                                           font: .systemFont(ofSize: 14, weight: .regular),
                                                           numberOfLines: 0)
    private let passwordField = Generator.generateField(contentType: .password,
                                                        textColor: .black,
                                                        placeholder: "Enter strong master password",
                                                        placeholderColor: .systemGray)
    private let repeatPasswordField = Generator.generateField(contentType: .password,
                                                              textColor: .black,
                                                              placeholder: "Repeat master password",
                                                              placeholderColor: .systemGray)
    private let saveButton = Generator.roundButton(text: "Save")
    
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
        Generator.generateBottomLineFor(field: passwordField, backgroundColor: .white, lineColor: .lightGray)
        Generator.generateBottomLineFor(field: repeatPasswordField, backgroundColor: .white, lineColor: .lightGray)
        
        saveButton.addTarget(self, action: #selector(tapOnSaveButton), for: .touchUpInside)
        
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
    
    private func triggerErrorNotification(errorText: String) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) { [weak self] in
            let clipboardNotification = ClipboardNotification()
            
            clipboardNotification.messageLabel.text = errorText
            
            self!.view.addSubview(clipboardNotification)
        }
    }
    
    @objc private func tapOnSaveButton() {
        guard let password = passwordField.text,
              let repeatPassword = repeatPasswordField.text
        else { return }
        
        guard !password.isEmpty && !repeatPassword.isEmpty else {
            return triggerErrorNotification(errorText: "Fill in the fields!")
        }
        
        guard password == repeatPassword else {
            return triggerErrorNotification(errorText: "Passwords do not match!")
        }
        
        dismiss(animated: true)
        
        completion(password)
    }
    
}
