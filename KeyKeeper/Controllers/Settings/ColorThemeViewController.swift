//
//  ColorThemeViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 12.11.2021.
//

import UIKit

class ColorThemeViewController: BaseChecklistTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.items = [
            "Automatic",
            "Light",
            "Dark",
        ].compactMap({
            ChecklistOption(title: $0)
        })
        
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Color theme"
    }
    
}
