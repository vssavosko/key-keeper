//
//  GeneratorViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 25.07.2021.
//

import UIKit

class GeneratorViewController: UIViewController {
    
    let testPassword = "88Z8Q(B1(D}+4"
    
    private let passwordField: UITextField = {
        let field = UITextField()
        
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        field.textAlignment = .center
        field.contentVerticalAlignment = .center
        field.borderStyle = .none
        field.isEnabled = false
        
        return field
    }()
    private let refreshButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.imageView?.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1.2)
        
        return button
    }()
    private let passwordLengthStackView = Generator.createStackView()
    private let numbersStackView = Generator.createStackView()
    private let lettersStackView = Generator.createStackView()
    private let charactersStackView = Generator.createStackView()
    private let lengthLabel = Generator.createLabel(text: "",
                                                    font: UIFont.systemFont(ofSize: 16, weight: .semibold),
                                                    color: .label)
    private let numbersLabel = Generator.createLabel(text: "0-9",
                                                     font: UIFont.systemFont(ofSize: 16, weight: .regular),
                                                     color: .label)
    private let lettersLabel = Generator.createLabel(text: "A-Z a-z",
                                                     font: UIFont.systemFont(ofSize: 16, weight: .regular),
                                                     color: .label)
    private let charactersLabel = Generator.createLabel(text: "!@#$%^&*",
                                                        font: UIFont.systemFont(ofSize: 16, weight: .regular),
                                                        color: .label)
    private let lengthSlider: UISlider = {
        let slider = UISlider()
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        return slider
    }()
    private let numbersSwitch = Generator.createSwitch()
    private let lettersSwitch = Generator.createSwitch()
    private let charactersSwitch = Generator.createSwitch()
    private let replaceButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Replace", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureSubviews()
        configureElements()
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Generator"
    }
    
    func configureSubviews() {
        view.addSubview(passwordField)
        view.addSubview(refreshButton)
        view.addSubview(passwordLengthStackView)
        view.addSubview(numbersStackView)
        view.addSubview(lettersStackView)
        view.addSubview(charactersStackView)
        passwordLengthStackView.addArrangedSubview(lengthLabel)
        passwordLengthStackView.addArrangedSubview(lengthSlider)
        numbersStackView.addArrangedSubview(numbersLabel)
        numbersStackView.addArrangedSubview(numbersSwitch)
        lettersStackView.addArrangedSubview(lettersLabel)
        lettersStackView.addArrangedSubview(lettersSwitch)
        charactersStackView.addArrangedSubview(charactersLabel)
        charactersStackView.addArrangedSubview(charactersSwitch)
        view.addSubview(replaceButton)
    }
    
    func configureElements() {
        passwordField.text = testPassword
        lengthLabel.text = "\(testPassword.count) Length"
        
        setupElementConstraints()
    }
    
    func setupElementConstraints() {
        passwordField.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                             leading: view.leadingAnchor,
                             bottom: nil,
                             trailing: refreshButton.leadingAnchor,
                             padding: UIEdgeInsets(top: 35, left: 16, bottom: 0, right: 0),
                             size: CGSize(width: (view.frame.width - refreshButton.imageView!.frame.width) - 32, height: 40))
        
        refreshButton.anchor(top: passwordField.topAnchor,
                             leading: passwordField.trailingAnchor,
                             bottom: nil,
                             trailing: view.trailingAnchor,
                             padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16),
                             size: CGSize(width: 0, height: 40))
        
        passwordLengthStackView.anchor(top: passwordField.bottomAnchor,
                                       leading: view.leadingAnchor,
                                       bottom: nil,
                                       trailing: view.trailingAnchor,
                                       padding: UIEdgeInsets(top: 35, left: 16, bottom: 0, right: 16),
                                       size: CGSize(width: view.frame.width - 32, height: 40))
        
        lengthLabel.anchor(top: passwordLengthStackView.topAnchor,
                           leading: passwordLengthStackView.leadingAnchor,
                           bottom: passwordLengthStackView.bottomAnchor,
                           trailing: lengthSlider.leadingAnchor,
                           padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16))
        
        lengthSlider.anchor(top: passwordLengthStackView.topAnchor,
                            leading: lengthLabel.trailingAnchor,
                            bottom: passwordLengthStackView.bottomAnchor,
                            trailing: passwordLengthStackView.trailingAnchor,
                            padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0))
        
        numbersStackView.anchor(top: passwordLengthStackView.bottomAnchor,
                                leading: view.leadingAnchor,
                                bottom: nil,
                                trailing: view.trailingAnchor,
                                padding: UIEdgeInsets(top: 20, left: 16, bottom: 0, right: 16),
                                size: CGSize(width: view.frame.width - 32, height: 40))
        
        numbersLabel.anchor(top: numbersStackView.topAnchor,
                            leading: numbersStackView.leadingAnchor,
                            bottom: numbersStackView.bottomAnchor,
                            trailing: numbersSwitch.leadingAnchor,
                            padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16))
        
        numbersSwitch.anchor(top: numbersStackView.topAnchor,
                             leading: numbersLabel.trailingAnchor,
                             bottom: numbersStackView.bottomAnchor,
                             trailing: numbersStackView.trailingAnchor,
                             padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0))
        
        lettersStackView.anchor(top: numbersStackView.bottomAnchor,
                                leading: view.leadingAnchor,
                                bottom: nil,
                                trailing: view.trailingAnchor,
                                padding: UIEdgeInsets(top: 5, left: 16, bottom: 0, right: 16),
                                size: CGSize(width: view.frame.width - 32, height: 40))
        
        lettersLabel.anchor(top: lettersStackView.topAnchor,
                            leading: lettersStackView.leadingAnchor,
                            bottom: lettersStackView.bottomAnchor,
                            trailing: lettersSwitch.leadingAnchor,
                            padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16))
        
        lettersSwitch.anchor(top: lettersStackView.topAnchor,
                             leading: lettersLabel.trailingAnchor,
                             bottom: lettersStackView.bottomAnchor,
                             trailing: lettersStackView.trailingAnchor,
                             padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0))
        
        charactersStackView.anchor(top: lettersStackView.bottomAnchor,
                                   leading: view.leadingAnchor,
                                   bottom: nil,
                                   trailing: view.trailingAnchor,
                                   padding: UIEdgeInsets(top: 5, left: 16, bottom: 0, right: 16),
                                   size: CGSize(width: view.frame.width - 32, height: 40))
        
        charactersLabel.anchor(top: charactersStackView.topAnchor,
                               leading: charactersStackView.leadingAnchor,
                               bottom: charactersStackView.bottomAnchor,
                               trailing: charactersSwitch.leadingAnchor,
                               padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16))
        
        charactersSwitch.anchor(top: charactersStackView.topAnchor,
                                leading: charactersLabel.trailingAnchor,
                                bottom: charactersStackView.bottomAnchor,
                                trailing: charactersStackView.trailingAnchor,
                                padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0))
        
        replaceButton.anchor(top: charactersStackView.bottomAnchor,
                             leading: view.leadingAnchor,
                             bottom: nil,
                             trailing: view.trailingAnchor,
                             padding: UIEdgeInsets(top: 35, left: 35, bottom: 0, right: 35),
                             size: CGSize(width: 0, height: 50))
    }
    
}
