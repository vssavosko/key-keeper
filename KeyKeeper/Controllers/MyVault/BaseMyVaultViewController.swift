//
//  BaseMyVaultViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 04.12.2021.
//

import UIKit
import Localize_Swift

class BaseMyVaultViewController: UIViewController {
    
    internal let titleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.text = "Title".localized()
        
        return label
    }()
    internal let titleField: TextFieldWithPadding = {
        let field = TextFieldWithPadding()
        
        field.font = .systemFont(ofSize: 17, weight: .regular)
        field.textColor = .label
        field.placeholder = "Pied Piper"
        
        return field
    }()
    
    internal let loginLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.text = "Email or username".localized()
        
        return label
    }()
    internal let loginField: TextFieldWithPadding = {
        let field = TextFieldWithPadding()
        
        field.font = .systemFont(ofSize: 17, weight: .regular)
        field.textColor = .label
        field.placeholder = "richardhendricks@piedpiper.com"
        field.textContentType = .username
        field.keyboardType = .emailAddress
        field.autocapitalizationType = .none
        
        return field
    }()
    
    internal let passwordLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.text = "Password".localized()
        
        return label
    }()
    internal let passwordField: TextFieldWithPadding = {
        let field = TextFieldWithPadding()
        
        field.font = .systemFont(ofSize: 17, weight: .regular)
        field.textColor = .label
        field.placeholder = "QwEr123Ty456"
        field.textContentType = .password
        field.isSecureTextEntry = true
        
        return field
    }()
    
    internal let websiteLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.text = "Website".localized()
        
        return label
    }()
    internal let websiteField: TextFieldWithPadding = {
        let field = TextFieldWithPadding()
        
        field.font = .systemFont(ofSize: 17, weight: .regular)
        field.textColor = .label
        field.placeholder = "www.piedpiper.com"
        field.textContentType = .URL
        field.keyboardType = .URL
        field.autocapitalizationType = .none
        
        return field
    }()
    
    internal let notesLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.text = "Notes".localized()
        
        return label
    }()
    internal let notesTextView: UITextView = {
        let textView = UITextView()
        
        textView.font = .systemFont(ofSize: 16)
        textView.textColor = .label
        textView.text = "Write some note..."
        textView.backgroundColor = .systemGray5
        textView.isScrollEnabled = false
        textView.layer.cornerRadius = 8
        
        return textView
    }()
    
    internal let passwordButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        
        return button
    }()
    internal let generatePasswordButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Generate password".localized(), for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        
        return button
    }()
    
    internal lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, titleField])
        
        stackView.axis = .vertical
        
        return stackView
    }()
    internal lazy var loginStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginLabel, loginField])
        
        stackView.axis = .vertical
        
        return stackView
    }()
    internal lazy var passwordStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [passwordLabel, passwordField])
        
        stackView.axis = .vertical
        
        return stackView
    }()
    internal lazy var websiteStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [websiteLabel, websiteField])
        
        stackView.axis = .vertical
        
        return stackView
    }()
    internal lazy var notesStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [notesLabel, notesTextView])
        
        stackView.axis = .vertical
        stackView.spacing = 10.0
        
        return stackView
    }()
    
    internal lazy var firstStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginStackView, passwordStackView])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10.0
        
        return stackView
    }()
    internal lazy var secondStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [websiteStackView, notesStackView])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10.0
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureNavigationBar()
        configureSubviews()
        configureElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        notesTextView.delegate = self
        notesTextView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
    }
    
    internal func configureNavigationBar() {}
    
    internal func configureSubviews() {
        view.addSubview(firstStackView)
        view.addSubview(secondStackView)
        view.addSubview(passwordButton)
        view.addSubview(generatePasswordButton)
    }
    
    internal func configureElements() {
        BottomLine.generateFor(element: titleStackView)
        BottomLine.generateFor(element: loginStackView)
        BottomLine.generateFor(element: websiteStackView)
        
        passwordButton.addTarget(self, action: #selector(tapOnPasswordButton), for: .touchUpInside)
        
        setupFieldConstraints()
    }
    
    internal func setupFieldConstraints() {
        firstStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              leading: view.leadingAnchor,
                              bottom: nil,
                              trailing: view.trailingAnchor,
                              padding: UIEdgeInsets(top: 9, left: 16, bottom: 0, right: 16))
        
        passwordButton.anchor(top: passwordField.topAnchor,
                              leading: nil,
                              bottom: passwordField.bottomAnchor,
                              trailing: passwordField.trailingAnchor,
                              padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
        generatePasswordButton.anchor(top: firstStackView.bottomAnchor,
                                      leading: nil,
                                      bottom: secondStackView.topAnchor,
                                      trailing: view.trailingAnchor,
                                      padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16))
        
        secondStackView.anchor(top: firstStackView.bottomAnchor,
                               leading: view.leadingAnchor,
                               bottom: nil,
                               trailing: view.trailingAnchor,
                               padding: UIEdgeInsets(top: 41, left: 16, bottom: 0, right: 16))
    }
    
    @objc internal func tapOnPasswordButton(sender: UIButton!) {
        passwordField.isSecureTextEntry = !passwordField.isSecureTextEntry
        
        if passwordField.isSecureTextEntry {
            passwordButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        } else {
            passwordButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        }
    }
    
}

extension BaseMyVaultViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard let notesTextViewText = notesTextView.text else { return }
        
        if !notesTextViewText.isEmpty && notesTextViewText == "Write some note..." {
            notesTextView.text = ""
            notesTextView.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if notesTextView.text.isEmpty {
            notesTextView.text = "Write some note..."
            notesTextView.textColor = .lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (notesTextView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        
        return numberOfChars < 250;
    }
    
}
