//
//  GeneratorViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 25.07.2021.
//

import UIKit

class GeneratorViewController: UIViewController {
    
    private let testPassword = "88Z8Q(B1(D}+4"
    
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
    private let passwordLengthStackView = Generator.generateStackView()
    private let numbersStackView = Generator.generateStackView()
    private let lettersStackView = Generator.generateStackView()
    private let charactersStackView = Generator.generateStackView()
    private let lengthLabel = Generator.generateLabel(text: "",
                                                      font: UIFont.systemFont(ofSize: 16, weight: .regular),
                                                      color: .label)
    private let numbersLabel = Generator.generateLabel(text: "0-9",
                                                       font: UIFont.systemFont(ofSize: 16, weight: .regular),
                                                       color: .label)
    private let lettersLabel = Generator.generateLabel(text: "A-Z a-z",
                                                       font: UIFont.systemFont(ofSize: 16, weight: .regular),
                                                       color: .label)
    private let charactersLabel = Generator.generateLabel(text: "!@#$%^&*",
                                                          font: UIFont.systemFont(ofSize: 16, weight: .regular),
                                                          color: .label)
    private let lengthSlider: UISlider = {
        let slider = UISlider()
        
        let thumbImage = Generator.generateThumb(size: CGSize(width: 20, height: 20))
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.setThumbImage(thumbImage, for: .normal)
        
        return slider
    }()
    private let numbersSwitch = Generator.generateSwitch()
    private let lettersSwitch = Generator.generateSwitch()
    private let charactersSwitch = Generator.generateSwitch()
    private let replaceButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Replace", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 25
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
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Generator"
    }
    
    private func configureSubviews() {
        view.addSubview(passwordField)
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
        view.addSubview(refreshButton)
        view.addSubview(replaceButton)
    }
    
    private func configureElements() {
        passwordField.text = testPassword
        lengthLabel.text = "\(testPassword.count) Length"
        
        setupFieldConstraints()
        setupStackViewConstraints(topAnchor: passwordField.bottomAnchor)
        setupButtonConstraints()
    }
    
    private func setupFieldConstraints() {
        passwordField.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                             leading: view.leadingAnchor,
                             bottom: nil,
                             trailing: refreshButton.leadingAnchor,
                             padding: UIEdgeInsets(top: 35, left: 16, bottom: 0, right: 0),
                             size: CGSize(width: (view.frame.width - refreshButton.imageView!.frame.width) - 32, height: 40))
    }
    
    private func setupStackViewConstraints(topAnchor: NSLayoutYAxisAnchor) {
        passwordLengthStackView.anchor(top: topAnchor,
                                       leading: view.leadingAnchor,
                                       bottom: nil,
                                       trailing: view.trailingAnchor,
                                       padding: UIEdgeInsets(top: 35, left: 16, bottom: 0, right: 16),
                                       size: CGSize(width: view.frame.width - 32, height: 40))
        
        lengthLabel.anchor(top: nil,
                           leading: nil,
                           bottom: nil,
                           trailing: lengthSlider.leadingAnchor,
                           padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16))
        
        lengthSlider.anchor(top: nil,
                            leading: lengthLabel.trailingAnchor,
                            bottom: nil,
                            trailing: nil,
                            padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0))
        
        numbersStackView.anchor(top: passwordLengthStackView.bottomAnchor,
                                leading: view.leadingAnchor,
                                bottom: nil,
                                trailing: view.trailingAnchor,
                                padding: UIEdgeInsets(top: 20, left: 16, bottom: 0, right: 16),
                                size: CGSize(width: view.frame.width - 32, height: 40))
        
        lettersStackView.anchor(top: numbersStackView.bottomAnchor,
                                leading: view.leadingAnchor,
                                bottom: nil,
                                trailing: view.trailingAnchor,
                                padding: UIEdgeInsets(top: 5, left: 16, bottom: 0, right: 16),
                                size: CGSize(width: view.frame.width - 32, height: 40))
        
        charactersStackView.anchor(top: lettersStackView.bottomAnchor,
                                   leading: view.leadingAnchor,
                                   bottom: nil,
                                   trailing: view.trailingAnchor,
                                   padding: UIEdgeInsets(top: 5, left: 16, bottom: 0, right: 16),
                                   size: CGSize(width: view.frame.width - 32, height: 40))
    }
    
    private func setupButtonConstraints() {
        refreshButton.anchor(top: passwordField.topAnchor,
                             leading: passwordField.trailingAnchor,
                             bottom: nil,
                             trailing: view.trailingAnchor,
                             padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16),
                             size: CGSize(width: 0, height: 40))
        
        replaceButton.anchor(top: charactersStackView.bottomAnchor,
                             leading: view.leadingAnchor,
                             bottom: nil,
                             trailing: view.trailingAnchor,
                             padding: UIEdgeInsets(top: 35, left: 35, bottom: 0, right: 35),
                             size: CGSize(width: 0, height: 50))
    }
    
}
