//
//  BaseMyVaultViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 04.12.2021.
//

import UIKit
import Localize_Swift

class BaseMyVaultViewController: UIViewController {
    
    internal let notePlaceholder = "You can leave a note here"
    internal var oneIconConstraint: NSLayoutConstraint?
    internal var twoIconConstraint: NSLayoutConstraint?
    
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
        field.placeholder = "piedpiper.com"
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
    internal lazy var notesTextView: UITextView = {
        let textView = UITextView()
        
        textView.font = .systemFont(ofSize: 16)
        textView.textColor = .placeholderText
        textView.text = notePlaceholder
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        textView.backgroundColor = .systemGray5
        textView.isScrollEnabled = false
        textView.layer.cornerRadius = 8
        
        return textView
    }()
    
    internal let passwordButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        
        button.addTarget(self, action: #selector(tapOnPasswordButton), for: .touchUpInside)
        
        return button
    }()
    internal let copyLoginButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "doc.on.doc.fill"), for: .normal)
        
        button.isHidden = true
        
        return button
    }()
    internal let copyPasswordButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "doc.on.doc.fill"), for: .normal)
        
        button.isHidden = true
        
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
        
        stackView.addBottomLine()
        
        return stackView
    }()
    internal lazy var loginFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginField, copyLoginButton])
        
        stackView.axis = .horizontal
        stackView.spacing = 10.0
        
        return stackView
    }()
    internal lazy var loginStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginLabel, loginFieldStackView])
        
        stackView.axis = .vertical
        
        stackView.addBottomLine()
        
        return stackView
    }()
    internal lazy var passwordButtonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [passwordButton, copyPasswordButton])
        
        stackView.axis = .horizontal
        stackView.spacing = 16.0
        
        return stackView
    }()
    internal lazy var passwordFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [passwordField, passwordButtonsStackView])
        
        stackView.axis = .horizontal
        stackView.spacing = 10.0
        
        return stackView
    }()
    internal lazy var passwordStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [passwordLabel, passwordFieldStackView])
        
        stackView.axis = .vertical
        
        return stackView
    }()
    internal lazy var websiteStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [websiteLabel, websiteField])
        
        stackView.axis = .vertical
        
        stackView.addBottomLine()
        
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
        
        oneIconConstraint = passwordButtonsStackView.widthAnchor.constraint(equalToConstant: 25)
        oneIconConstraint?.isActive = true
        
        twoIconConstraint = passwordButtonsStackView.widthAnchor.constraint(equalToConstant: 70)
        
        configureNavigationBar()
        configureSubviews()
        configureElements()
    }
    
    internal func configureNavigationBar() {}
    
    internal func configureSubviews() {
        view.addSubview(firstStackView)
        view.addSubview(secondStackView)
        view.addSubview(generatePasswordButton)
    }
    
    internal func configureElements() {
        notesTextView.delegate = self
        
        if notesTextView.text != notePlaceholder {
            notesTextView.textColor = .label
        }
        
        setupFieldConstraints()
    }
    
    internal func setupFieldConstraints() {
        firstStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              leading: view.leadingAnchor,
                              bottom: nil,
                              trailing: view.trailingAnchor,
                              padding: UIEdgeInsets(top: 9, left: 16, bottom: 0, right: 16))
        
        loginField.anchor(top: loginFieldStackView.topAnchor,
                          leading: loginFieldStackView.leadingAnchor,
                          bottom: loginFieldStackView.bottomAnchor,
                          trailing: nil,
                          size: CGSize(width: loginFieldStackView.frame.width - copyLoginButton.frame.width, height: 0))
        
        copyLoginButton.anchor(top: nil,
                               leading: nil,
                               bottom: nil,
                               trailing: loginFieldStackView.trailingAnchor,
                               size: CGSize(width: 25, height: 0))
        
        passwordField.anchor(top: passwordFieldStackView.topAnchor,
                             leading: passwordFieldStackView.leadingAnchor,
                             bottom: passwordFieldStackView.bottomAnchor,
                             trailing: nil,
                             size: CGSize(width: passwordFieldStackView.frame.width - passwordButtonsStackView.frame.width, height: 0))
        
        passwordButtonsStackView.anchor(top: nil,
                                        leading: nil,
                                        bottom: nil,
                                        trailing: passwordFieldStackView.trailingAnchor)
        
        generatePasswordButton.anchor(top: firstStackView.bottomAnchor,
                                      leading: nil,
                                      bottom: secondStackView.topAnchor,
                                      trailing: view.trailingAnchor,
                                      padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        
        secondStackView.anchor(top: firstStackView.bottomAnchor,
                               leading: view.leadingAnchor,
                               bottom: nil,
                               trailing: view.trailingAnchor,
                               padding: UIEdgeInsets(top: 41, left: 16, bottom: 0, right: 16))
        
        notesTextView.anchor(top: notesLabel.bottomAnchor,
                             leading: secondStackView.leadingAnchor,
                             bottom: nil,
                             trailing: secondStackView.trailingAnchor,
                             padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0),
                             size: CGSize(width: 0, height: 75))
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
        
        if !notesTextViewText.isEmpty && notesTextViewText == notePlaceholder {
            notesTextView.text = ""
            notesTextView.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if notesTextView.text.isEmpty {
            notesTextView.text = notePlaceholder
            notesTextView.textColor = .placeholderText
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (notesTextView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        
        return numberOfChars < 250;
    }
    
}
