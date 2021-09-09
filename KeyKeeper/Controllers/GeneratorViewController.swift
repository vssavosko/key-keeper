//
//  GeneratorViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 25.07.2021.
//

import UIKit

class GeneratorViewController: UIViewController {
    
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
    private var refreshButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.imageView?.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1.2)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureSubviews()
        configureFields()
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Generator"
    }
    
    func configureSubviews() {
        view.addSubview(passwordField)
        view.addSubview(refreshButton)
    }
    
    func configureFields() {
        passwordField.text = "88Z8Q(B1(D}+4"
        
        setupFieldConstraints()
    }
    
    func setupFieldConstraints() {
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
    }
    
}
