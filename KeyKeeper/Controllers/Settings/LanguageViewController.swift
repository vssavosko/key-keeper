//
//  LanguageViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 12.11.2021.
//

import UIKit
import Localize_Swift

class LanguageViewController: BaseChecklistTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureElements()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let option = options[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ChecklistTableViewCell.identifier,
                                                 for: indexPath) as! ChecklistTableViewCell
        
        let languageState = UserDefaults.standard.integer(forKey: Keys.language)
        
        if languageState == indexPath.row {
            option.isChecked = true
        }
        
        cell.configure(with: option)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
        UserDefaults.standard.set(indexPath.row, forKey: Keys.language)
        
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
    }
    
    private func configureNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Language".localized()
    }
    
    private func configureElements() {
        self.options = [
            "System language".localized(),
            "Russian".localized(),
            "English".localized(),
        ].compactMap({
            ChecklistOptions(title: $0)
        })
    }
    
    @objc private func updateRootViewController() {
        let tabBarController = MainTabBarController()
        
        let myVaultVC = tabBarController.createNavController(vc: MyVaultViewController(),
                                                             image: "lock.fill",
                                                             title: "My Vault".localized())
        let generatorVC = tabBarController.createNavController(vc: GeneratorViewController(),
                                                               image: "key.fill",
                                                               title: "Generator".localized())
        let settingsVC = tabBarController.createNavController(vc: SettingsViewController(),
                                                              image: "gearshape.fill",
                                                              title: "Settings".localized())
        
        tabBarController.setViewControllers([myVaultVC, generatorVC, settingsVC], animated: false)
        
        self.view.window?.rootViewController = tabBarController
    }
    
}
