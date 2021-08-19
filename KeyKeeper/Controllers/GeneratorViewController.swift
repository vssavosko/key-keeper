//
//  GeneratorViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 25.07.2021.
//

import UIKit

class GeneratorViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Generator"
    }
    
}