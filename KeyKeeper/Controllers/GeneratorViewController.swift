//
//  GeneratorViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 25.07.2021.
//

import UIKit
import Localize_Swift

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
        
        button.addTarget(self, action: #selector(tapOnRefreshButton), for: .touchUpInside)
        
        return button
    }()
    private let lengthLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = ""
        
        return label
    }()
    private let lettersLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "A-Z a-z"
        
        return label
    }()
    private let symbolsLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "!@#$%^&*"
        
        return label
    }()
    private let lengthSlider: UISlider = {
        let slider = UISlider()
        let size = CGSize(width: 20, height: 20)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(UIColor.systemBlue.cgColor)
        context?.setStrokeColor(UIColor.clear.cgColor)
        
        let bounds = CGRect(origin: .zero, size: size)
        
        context?.addEllipse(in: bounds)
        context?.drawPath(using: .fill)
        
        let thumbImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        slider.setThumbImage(thumbImage, for: .normal)
        slider.minimumValue = 4
        slider.maximumValue = 40
        slider.value = 10
        slider.isContinuous = true
        
        slider.addTarget(self, action: #selector(sliderDidChange), for: .valueChanged)
        
        return slider
    }()
    private let lettersSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        
        return uiSwitch
    }()
    private let symbolsSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        
        return uiSwitch
    }()
    private lazy var passwordLengthStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [lengthLabel, lengthSlider])
        
        stackView.axis = .horizontal
        stackView.spacing = 10.0
        
        return stackView
    }()
    private lazy var lettersStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [lettersLabel, lettersSwitch])
        
        stackView.axis = .horizontal
        
        return stackView
    }()
    private lazy var symbolsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [symbolsLabel, symbolsSwitch])
        
        stackView.axis = .horizontal
        
        return stackView
    }()
    private let copyButton: RoundButton = {
        let button = RoundButton(text: "Copy".localized())
        
        button.addTarget(self, action: #selector(tapOnCopyButton), for: .touchUpInside)
        
        return button
    }()
    private let replaceButton: RoundButton = {
        let button = RoundButton(text: "Replace".localized())
        
        button.addTarget(self, action: #selector(tapOnReplaceButton), for: .touchUpInside)
        
        return button
    }()
    private lazy var parameterStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [passwordLengthStackView, lettersStackView, symbolsStackView])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10.0
        
        return stackView
    }()
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [copyButton, replaceButton])
        
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
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Generator".localized()
    }
    
    private func configureSubviews() {
        view.addSubview(passwordField)
        view.addSubview(refreshButton)
        view.addSubview(parameterStackView)
        view.addSubview(buttonStackView)
    }
    
    private func configureElements() {
        let randomValue = generateRandomValue(valueLength: 10, randomValueType: .lettersAndNumbers)
        
        passwordField.text = randomValue
        lengthLabel.text = "\("Length".localized()) \(randomValue.count)"
        
        lettersSwitch.isOn = true
        
        copyButton.isHidden = completion != nil
        replaceButton.isHidden = completion == nil
        
        setupElementConstraints()
    }
    
    private func setupElementConstraints() {
        passwordField.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                             leading: view.leadingAnchor,
                             bottom: parameterStackView.topAnchor,
                             trailing: refreshButton.leadingAnchor,
                             padding: UIEdgeInsets(top: 35, left: 16, bottom: 35, right: 0),
                             size: CGSize(width: (view.frame.width - refreshButton.imageView!.frame.width) - 32, height: 40))
        refreshButton.anchor(top: passwordField.topAnchor,
                             leading: passwordField.trailingAnchor,
                             bottom: passwordField.bottomAnchor,
                             trailing: view.trailingAnchor,
                             padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16),
                             size: CGSize(width: 0, height: 40))
        parameterStackView.anchor(top: passwordField.bottomAnchor,
                                  leading: view.leadingAnchor,
                                  bottom: buttonStackView.topAnchor,
                                  trailing: view.trailingAnchor,
                                  padding: UIEdgeInsets(top: 35, left: 16, bottom: 35, right: 16))
        buttonStackView.anchor(top: parameterStackView.bottomAnchor,
                               leading: view.leadingAnchor,
                               bottom: nil,
                               trailing: view.trailingAnchor,
                               padding: UIEdgeInsets(top: 35, left: 16, bottom: 0, right: 16),
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
            lengthLabel.text = "\("Length".localized()) \(value)"
        }
        
        passwordField.text = randomValue
    }
    
    @objc private func sliderDidChange() {
        passwordAction(for: .slider)
    }
    
    @objc private func tapOnRefreshButton() {
        passwordAction(for: .button)
    }
    
    @objc private func tapOnCopyButton() {
        guard let password = self.passwordField.text else { return }
        
        self.triggerNotification() {
            UIPasteboard.general.string = password
        }
    }
    
    @objc private func tapOnReplaceButton() {
        guard let password = passwordField.text,
              let completion = completion
        else { return }
        
        completion(password)
        
        navigationController?.popViewController(animated: true)
    }
    
}
