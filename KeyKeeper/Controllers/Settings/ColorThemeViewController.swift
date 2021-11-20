//
//  ColorThemeViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 12.11.2021.
//

import UIKit

class ColorThemeViewController: BaseChecklistTableViewController {
    
    private let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        
        self.options = [
            "Automatic",
            "Light",
            "Dark",
        ].compactMap({
            ChecklistOption(title: $0)
        })
    }
    
    func configureNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Color theme"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let themeState = userDefaults.integer(forKey: Keys.theme)
        let option = options[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ChecklistTableViewCell.identifier,
                                                 for: indexPath) as! ChecklistTableViewCell
        
        if themeState == indexPath.row {
            option.isChecked = true
        }
        
        if let window = self.view.window {
            ColorTheme.setColorTheme(window: window, themeState: themeState)
        }
        
        cell.configure(with: option)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
        userDefaults.set(indexPath.row, forKey: Keys.theme)
    }
    
}
