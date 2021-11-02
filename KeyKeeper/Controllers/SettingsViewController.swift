//
//  SettingsViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 25.07.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let biometricDescriptionLabel = Generator.generateLabel(text: "YOUR MASTER PASSWORD WILL BE PERIODICALLY\nREQUESTED FOR SECURITY",
                                                                    font: .systemFont(ofSize: 13, weight: .regular),
                                                                    numberOfLines: 2)
    private let biometricValueLabel = Generator.generateLabel(text: "Touch ID / Face ID",
                                                              textColor: .white,
                                                              font: .systemFont(ofSize: 17, weight: .regular))
    private let biometricSwitch = Generator.generateSwitch()
    private lazy var biometricStackView = Generator.generateStackView(subviews: [biometricValueLabel, biometricSwitch])
    private let clipboardDescriptionLabel = Generator.generateLabel(text: "AUTOMATICALLY CLEAR THE CLIPBOARD AFTER\n30 SECONDS",
                                                                    font: .systemFont(ofSize: 13, weight: .regular),
                                                                    numberOfLines: 2)
    private let clipboardValueLabel = Generator.generateLabel(text: "Clear the clipboard",
                                                              textColor: .white,
                                                              font: .systemFont(ofSize: 17, weight: .regular))
    private let clipboardSwitch = Generator.generateSwitch()
    private lazy var clipboardStackView = Generator.generateStackView(subviews: [clipboardValueLabel, clipboardSwitch])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureNavigationBar()
        configureSubviews()
        configureElements()
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Settings"
    }
    
    func configureSubviews() {
        view.addSubview(biometricDescriptionLabel)
        view.addSubview(biometricStackView)
        view.addSubview(clipboardDescriptionLabel)
        view.addSubview(clipboardStackView)
    }
    
    func configureElements() {
        setupElementConstraints()
    }
    
    func setupElementConstraints() {
        biometricDescriptionLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                         leading: view.leadingAnchor,
                                         bottom: nil,
                                         trailing: view.trailingAnchor,
                                         padding: UIEdgeInsets(top: 12, left: 16, bottom: 0, right: 16))
        
        biometricStackView.anchor(top: biometricDescriptionLabel.bottomAnchor,
                                  leading: view.leadingAnchor,
                                  bottom: nil,
                                  trailing: view.trailingAnchor,
                                  padding: UIEdgeInsets(top: 12, left: 16, bottom: 0, right: 16))
        
        clipboardDescriptionLabel.anchor(top: biometricStackView.bottomAnchor,
                                         leading: view.leadingAnchor,
                                         bottom: nil,
                                         trailing: view.trailingAnchor,
                                         padding: UIEdgeInsets(top: 12, left: 16, bottom: 0, right: 16))
        
        clipboardStackView.anchor(top: clipboardDescriptionLabel.bottomAnchor,
                                  leading: view.leadingAnchor,
                                  bottom: nil,
                                  trailing: view.trailingAnchor,
                                  padding: UIEdgeInsets(top: 12, left: 16, bottom: 0, right: 16))
    }
    
}
