//
//  GeneratorViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 25.07.2021.
//

import UIKit

class GeneratorViewController: UIViewController {
    
    var completion: ((String) -> Void)?
    
    private enum ElementType {
        case slider
        case button
    }
    
    private enum RandomValueType {
        case numbers
        case lettersAndNumbers
        case symbolsAndNumbers
        case all
    }
    
    private let passwordField: UITextField = {
        let field = UITextField()
        
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = .systemFont(ofSize: 25, weight: .semibold)
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
    private lazy var passwordLengthStackView = Generator.generateStackView(subviews: [lengthLabel, lengthSlider])
    private lazy var lettersStackView = Generator.generateStackView(subviews: [lettersLabel, lettersSwitch])
    private lazy var symbolsStackView = Generator.generateStackView(subviews: [symbolsLabel, symbolsSwitch])
    private let lengthLabel = Generator.generateLabel(text: "",
                                                      textColor: .label,
                                                      font: .systemFont(ofSize: 16, weight: .regular))
    private let lettersLabel = Generator.generateLabel(text: "A-Z a-z",
                                                       textColor: .label,
                                                       font: .systemFont(ofSize: 16, weight: .regular))
    private let symbolsLabel = Generator.generateLabel(text: "!@#$%^&*",
                                                       textColor: .label,
                                                       font: .systemFont(ofSize: 16, weight: .regular))
    private let lengthSlider: UISlider = {
        let slider = UISlider()
        
        let thumbImage = Generator.generateThumb(size: CGSize(width: 20, height: 20))
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.setThumbImage(thumbImage, for: .normal)
        slider.minimumValue = 4
        slider.maximumValue = 40
        slider.isContinuous = true
        
        return slider
    }()
    private let lettersSwitch = Generator.generateSwitch()
    private let symbolsSwitch = Generator.generateSwitch()
    private let copyButton = Generator.roundButton(text: "Copy")
    private let replaceButton = Generator.roundButton(text: "Replace")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
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
        view.addSubview(lettersStackView)
        view.addSubview(symbolsStackView)
        view.addSubview(refreshButton)
        view.addSubview(copyButton)
        view.addSubview(replaceButton)
    }
    
    private func configureElements() {
        let randomValue = generateRandomValue(valueLength: 4, randomValueType: .numbers)
        
        passwordField.text = randomValue
        lengthLabel.text = "\(randomValue.count) Length"
        
        copyButton.isHidden = completion != nil
        replaceButton.isHidden = completion == nil
        
        lengthSlider.addTarget(self, action: #selector(sliderDidChange), for: .valueChanged)
        refreshButton.addTarget(self, action: #selector(tapOnRefreshButton), for: .touchUpInside)
        copyButton.addTarget(self, action: #selector(tapOnCopyButton), for: .touchUpInside)
        replaceButton.addTarget(self, action: #selector(tapOnReplaceButton), for: .touchUpInside)
        
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
                           padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16),
                           size: CGSize(width: 75, height: 0))
        
        lengthSlider.anchor(top: nil,
                            leading: lengthLabel.trailingAnchor,
                            bottom: nil,
                            trailing: nil,
                            padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0))
        
        lettersStackView.anchor(top: passwordLengthStackView.bottomAnchor,
                                leading: view.leadingAnchor,
                                bottom: nil,
                                trailing: view.trailingAnchor,
                                padding: UIEdgeInsets(top: 5, left: 16, bottom: 0, right: 16),
                                size: CGSize(width: view.frame.width - 32, height: 40))
        
        symbolsStackView.anchor(top: lettersStackView.bottomAnchor,
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
        
        copyButton.anchor(top: symbolsStackView.bottomAnchor,
                          leading: view.leadingAnchor,
                          bottom: nil,
                          trailing: view.trailingAnchor,
                          padding: UIEdgeInsets(top: 35, left: 35, bottom: 0, right: 35),
                          size: CGSize(width: 0, height: 50))
        
        replaceButton.anchor(top: symbolsStackView.bottomAnchor,
                             leading: view.leadingAnchor,
                             bottom: nil,
                             trailing: view.trailingAnchor,
                             padding: UIEdgeInsets(top: 35, left: 35, bottom: 0, right: 35),
                             size: CGSize(width: 0, height: 50))
    }
    
    private func generateRandomValue(valueLength: Int, randomValueType: RandomValueType) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let numbers = "0123456789"
        let symbols = "!@#$%^&*"
        let lettersAndNumbers = "\(letters)\(numbers)"
        let symbolsAndNumbers = "\(symbols)\(numbers)"
        let all = "\(letters)\(numbers)\(symbols)"
        
        var value = String()
        
        for _ in 1...valueLength {
            switch randomValueType {
            case .numbers:
                value += String(numbers.randomElement()!)
            case .lettersAndNumbers:
                value += String(lettersAndNumbers.randomElement()!)
            case .symbolsAndNumbers:
                value += String(symbolsAndNumbers.randomElement()!)
            case .all:
                value += String(all.randomElement()!)
            }
        }
        
        return value
    }
    
    private func passwordAction(for element: ElementType) {
        let value = Int(lengthSlider.value)
        
        var randomValue = String()
        
        if lettersSwitch.isOn && symbolsSwitch.isOn {
            randomValue = generateRandomValue(valueLength: value, randomValueType: .all)
        } else if lettersSwitch.isOn {
            randomValue = generateRandomValue(valueLength: value, randomValueType: .lettersAndNumbers)
        } else if symbolsSwitch.isOn {
            randomValue = generateRandomValue(valueLength: value, randomValueType: .symbolsAndNumbers)
        } else {
            randomValue = generateRandomValue(valueLength: value, randomValueType: .numbers)
        }
        
        if element == .slider {
            lengthLabel.text = "\(value) Length"
        }
        
        passwordField.text = randomValue
    }
    
    @objc func sliderDidChange() {
        passwordAction(for: .slider)
    }
    
    @objc func tapOnRefreshButton() {
        passwordAction(for: .button)
    }
    
    @objc func tapOnCopyButton() {
        guard let password = self.passwordField.text else { return }
        
        self.triggerNotification() {
            UIPasteboard.general.string = password
        }
    }
    
    @objc func tapOnReplaceButton() {
        guard let password = passwordField.text,
              let completion = completion
        else { return }
        
        completion(password)
        
        navigationController?.popViewController(animated: true)
    }
    
}
