//
//  LanguageViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 12.11.2021.
//

import UIKit

class LanguageViewController: BaseChecklistTableViewController {
    
    private let userDefaults = UserDefaults.standard
    
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let option = options[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ChecklistTableViewCell.identifier,
                                                 for: indexPath) as! ChecklistTableViewCell
        
        let languageState = userDefaults.integer(forKey: Keys.language)
        
        if languageState == indexPath.row {
            option.isChecked = true
        }
        
        cell.configure(with: option)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
        userDefaults.set(indexPath.row, forKey: Keys.language)
    }
    
}
