//
//  LanguageViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 12.11.2021.
//

import UIKit

class LanguageViewController: BaseChecklistTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        
        self.options = [
            "Automatic",
            "Russian",
            "English"
        ].compactMap({
            ChecklistOption(title: $0)
        })
    }
    
    func configureNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Language"
    }
    
}
