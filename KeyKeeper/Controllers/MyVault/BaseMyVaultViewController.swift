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
    
    internal let titleLabel: UniversalLabel = {
        let label = UniversalLabel(text: "Title")
        
        return label
    }()
    internal let titleField: UniversalField = {
        let field = UniversalField(placeholder: "Pied Piper")
        
        return field
    }()
    
    internal let loginLabel: UniversalLabel = {
        let label = UniversalLabel(text: "Email or username")
        
        return label
    }()
    internal let loginField: UniversalField = {
        let field = UniversalField(placeholder: "richardhendricks@piedpiper.com", fieldType: .login)
        
        return field
    }()
    
    internal let passwordLabel: UniversalLabel = {
        let label = UniversalLabel(text: "Password")
        
        return label
    }()
    internal let passwordField: UniversalField = {
        let field = UniversalField(placeholder: "QwEr123Ty456", fieldType: .password)
        
        return field
    }()
    
    internal let websiteLabel: UniversalLabel = {
        let label = UniversalLabel(text: "Website")
        
        return label
    }()
    internal let websiteField: UniversalField = {
        let field = UniversalField(placeholder: "piedpiper.com", fieldType: .website)
        
        return field
    }()
    
    internal let notesLabel: UniversalLabel = {
        let label = UniversalLabel(text: "Notes")
        
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
    
    internal let passwordButton: UniversalButton = {
        let button = UniversalButton(systemImageName: "eye.fill")
        
        button.addTarget(self, action: #selector(tapOnPasswordButton), for: .touchUpInside)
        
        return button
    }()
    internal let copyLoginButton: UniversalButton = {
        let button = UniversalButton(systemImageName: "doc.on.doc.fill")
        
        button.isHidden = true
        
        return button
    }()
    internal let copyPasswordButton: UniversalButton = {
        let button = UniversalButton(systemImageName: "doc.on.doc.fill")
        
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
    
    internal lazy var accountDataStackView: FormStackView = {
        let stackView = FormStackView(arrangedSubviews: [loginStackView, passwordStackView])
        
        return stackView
    }()
    internal lazy var additionalInfoStackView: FormStackView = {
        let stackView = FormStackView(arrangedSubviews: [websiteStackView, notesStackView])
        
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
        view.addSubview(accountDataStackView)
        view.addSubview(additionalInfoStackView)
        view.addSubview(generatePasswordButton)
    }
    
    internal func configureElements() {
        notesTextView.delegate = self
        
        if notesTextView.text != notePlaceholder {
            notesTextView.textColor = .label
        }
        
        setupElementConstraints()
    }
    
    internal func setupElementConstraints() {
        accountDataStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
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
        
        generatePasswordButton.anchor(top: accountDataStackView.bottomAnchor,
                                      leading: nil,
                                      bottom: additionalInfoStackView.topAnchor,
                                      trailing: view.trailingAnchor,
                                      padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        
        additionalInfoStackView.anchor(top: accountDataStackView.bottomAnchor,
                                       leading: view.leadingAnchor,
                                       bottom: nil,
                                       trailing: view.trailingAnchor,
                                       padding: UIEdgeInsets(top: 41, left: 16, bottom: 0, right: 16))
        
        notesTextView.anchor(top: notesLabel.bottomAnchor,
                             leading: additionalInfoStackView.leadingAnchor,
                             bottom: nil,
                             trailing: additionalInfoStackView.trailingAnchor,
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
