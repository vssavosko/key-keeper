//
//  ColorThemeViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 12.11.2021.
//

import UIKit
import Localize_Swift

class ColorThemeViewController: BaseChecklistTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureElements()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let option = options[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ChecklistTableViewCell.identifier,
                                                 for: indexPath) as! ChecklistTableViewCell
        
        let themeState = UserDefaults.standard.integer(forKey: Keys.theme)
        
        if themeState == indexPath.row {
            option.isChecked = true
        }
        
        if let window = self.view.window {
            ColorTheme.shared.setColorTheme(window, themeState: themeState)
        }
        
        cell.configure(with: option)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
        UserDefaults.standard.set(indexPath.row, forKey: Keys.theme)
    }
    
    private func configureNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Color theme".localized()
    }
    
    private func configureElements() {
        self.options = [
            "System theme".localized(),
            "Light".localized(),
            "Dark".localized(),
        ].compactMap({
            ChecklistOptions(title: $0)
        })
    }
    
}
