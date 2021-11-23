//
//  LanguageViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 12.11.2021.
//

import UIKit
import Localize_Swift

class LanguageViewController: BaseChecklistTableViewController {
    
    private let userDefaults = UserDefaults.standard
    
    var automatic: String!
    var russian: String!
    var english: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setText()
        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setText),
                                               name: NSNotification.Name(LCLLanguageChangeNotification),
                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func setText() {
        navigationItem.title = "Language".localized()

        automatic = "Automatic".localized()
        russian = "Russian".localized()
        english = "English".localized()
        
        self.options = [
            automatic,
            russian,
            english,
        ].compactMap({
            ChecklistOption(title: $0)
        })
    }
    
    func configureNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
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
        
        switch indexPath.row {
        case 0:
            Localize.resetCurrentLanguageToDefault()
            
            break
        case 1:
            Localize.setCurrentLanguage("ru")
            
            break
        case 2:
            Localize.setCurrentLanguage("en")
            
            break
        default:
            Localize.resetCurrentLanguageToDefault()
        }
        
        print("current lang: \(Localize.currentLanguage())")
    }
    
}
