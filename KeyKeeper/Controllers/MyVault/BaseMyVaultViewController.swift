//
//  BaseMyVaultViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 04.12.2021.
//

import UIKit
import Localize_Swift

class BaseMyVaultViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.text = "title".localized()
        
        return label
    }()
    let titleField: TextFieldWithPadding = {
        let field = TextFieldWithPadding()
        
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = .systemFont(ofSize: 17, weight: .regular)
        field.textColor = .label
        field.placeholder = "Pied Piper".localized()
        
        return field
    }()
    
    let loginLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.text = "Email or username".localized()
        
        return label
    }()
    let loginField: TextFieldWithPadding = {
        let field = TextFieldWithPadding()
        
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = .systemFont(ofSize: 17, weight: .regular)
        field.textColor = .label
        field.placeholder = "richardhendricks@piedpiper.com".localized()
        field.textContentType = .username
        field.keyboardType = .emailAddress
        field.autocapitalizationType = .none
        
        return field
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.text = "Password".localized()
        
        return label
    }()
    let passwordField: TextFieldWithPadding = {
        let field = TextFieldWithPadding()
        
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = .systemFont(ofSize: 17, weight: .regular)
        field.textColor = .label
        field.placeholder = "QwEr123Ty456".localized()
        field.textContentType = .password
        field.isSecureTextEntry = true
        
        return field
    }()
    
    let websiteLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.text = "Website".localized()
        
        return label
    }()
    let websiteField: TextFieldWithPadding = {
        let field = TextFieldWithPadding()
        
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = .systemFont(ofSize: 17, weight: .regular)
        field.textColor = .label
        field.placeholder = "www.piedpiper.com".localized()
        field.textContentType = .URL
        field.keyboardType = .URL
        field.autocapitalizationType = .none
        
        return field
    }()
    
    let notesLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.text = "Notes".localized()
        
        return label
    }()
    let notesTextView: UITextView = {
        let textView = UITextView()
        
        textView.font = .systemFont(ofSize: 16)
        textView.textColor = .lightGray
        textView.text = "Write some note..."
        textView.backgroundColor = .systemGray5
        textView.isScrollEnabled = false
        textView.layer.cornerRadius = 5
        
        return textView
    }()
    
    let passwordButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        
        return button
    }()
    let generatePasswordButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Generate password".localized(), for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        
        return button
    }()
    
    lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, titleField])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        
        return stackView
    }()
    lazy var loginStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginLabel, loginField])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        
        return stackView
    }()
    lazy var passwordStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [passwordLabel, passwordField])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        
        return stackView
    }()
    lazy var websiteStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [websiteLabel, websiteField])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        
        return stackView
    }()
    lazy var notesStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [notesLabel, notesTextView])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 5
        
        return stackView
    }()
    
    lazy var firstStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginStackView, passwordStackView])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
//        stackView.alignment = .trailing
        stackView.spacing = 10.0
        
        return stackView
    }()
    lazy var secondStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [websiteStackView, notesStackView]) // dateStackView
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 10.0
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureNavigationBar()
        configureSubviews()
        configureFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        notesTextView.delegate = self
    }
    
    func configureNavigationBar() {}
    
    func configureSubviews() {
        view.addSubview(firstStackView)
        view.addSubview(secondStackView)
        view.addSubview(passwordButton)
    }
    
    func configureFields() {
        notesTextView.frame = CGRect(x: 0, y: notesLabel.frame.minY + 10, width: view.frame.width, height: 300)
        
        Generator.generateBottomLineFor(element: titleField)
        Generator.generateBottomLineFor(element: loginField)
        Generator.generateBottomLineFor(element: websiteField)
        
        passwordButton.addTarget(self, action: #selector(tapOnPasswordButton), for: .touchUpInside)
        
        //        titleField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        //        loginField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        //        passwordField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        //        passwordButton.addTarget(self, action: #selector(tapOnPasswordButton), for: .touchUpInside)
        //        generatePasswordButton.addTarget(self, action: #selector(tapOnGeneratorButton), for: .touchUpInside)
        //
        //        passwordButton.isEnabled = false
        
        setupFieldConstraints()
    }
    
    func setupFieldConstraints() {
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
        
        secondStackView.anchor(top: firstStackView.bottomAnchor,
                               leading: view.leadingAnchor,
                               bottom: nil,
                               trailing: view.trailingAnchor,
                               padding: UIEdgeInsets(top: 41, left: 16, bottom: 0, right: 16))
    }
    
    @objc func tapOnPasswordButton(sender: UIButton!) {
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
