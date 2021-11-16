//
//  SettingsViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 25.07.2021.
//

import UIKit
import SwiftKeychainWrapper

enum SettingsOptionType {
    
    case staticCell(model: SettingsOption)
    case switchCell(model: SettingsSwitchOption)
    
}

class SettingsViewController: UIViewController {
    
    private var models = [Section]()
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero,
                                style: .grouped)
        
        table.register(SettingsTableViewCell.self,
                       forCellReuseIdentifier: SettingsTableViewCell.identifier)
        
        table.register(SettingsSwitchTableViewCell.self,
                       forCellReuseIdentifier: SettingsSwitchTableViewCell.identifier)
        
        table.clipsToBounds = true
        table.layer.cornerRadius = 20
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureNavigationBar()
        configureSubviews()
        configureElements()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Settings"
    }
    
    private func configureSubviews() {
        view.addSubview(tableView)
    }
    
    private func configureElements() {
        tableView.delegate = self
        tableView.dataSource = self
        
        self.models = [
            Section(
                title: "PERIODICALLY REQUESTED FOR SECURITY",
                options: [
                    .switchCell(
                        model: SettingsSwitchOption(
                            title: "Touch ID / Face ID",
                            icon: nil,
                            iconBackgroundColor: .clear,
                            isOn: false) {
                                print("Touch ID / Face ID")
                            }
                    )
                ]
            ),
            Section(
                title: "CLEAR THE CLIPBOARD AFTER 30 SECONDS",
                options: [
                    .switchCell(
                        model: SettingsSwitchOption(
                            title: "Clear the clipboard",
                            icon: nil,
                            iconBackgroundColor: .clear,
                            isOn: false) {
                                print("Clear the clipboard")
                            }
                    )
                ]
            ),
            Section(
                title: "Other",
                options: [
                    .staticCell(
                        model: SettingsOption(
                            title: "Change language",
                            icon: nil,
                            iconBackgroundColor: .clear) { [weak self] in
                                let languageVC = LanguageViewController()
                                
                                self?.navigationController?.pushViewController(languageVC, animated: true)
                            }
                    ),
                    .staticCell(
                        model: SettingsOption(
                            title: "Change color theme",
                            icon: nil,
                            iconBackgroundColor: .clear) { [weak self] in
                                let colorThemeVC = ColorThemeViewController()
                                
                                self?.navigationController?.pushViewController(colorThemeVC, animated: true)
                            }
                    ),
                    .staticCell(
                        model: SettingsOption(
                            title: "Change Master Password",
                            icon: nil,
                            iconBackgroundColor: .clear) { [weak self] in
                                let masterPassword = KeychainWrapper.standard.string(forKey: Keys.masterPassword)
                                let alert = UIAlertController(title: "Change Master Password",
                                                              message: nil,
                                                              preferredStyle: .alert)
                                
                                alert.addTextField { field in
                                    field.placeholder = "Current password"
                                    field.isSecureTextEntry = true
                                }
                                
                                alert.addTextField { field in
                                    field.placeholder = "New password"
                                    field.isSecureTextEntry = true
                                }
                                
                                alert.addTextField { field in
                                    field.placeholder = "Repeat new password"
                                    field.isSecureTextEntry = true
                                }
                                
                                alert.addAction(UIAlertAction(title: "Cancel",
                                                              style: .cancel,
                                                              handler: nil))
                                
                                alert.addAction(
                                    UIAlertAction(
                                        title: "Change",
                                        style: .default,
                                        handler: { [weak self] _ in
                                            guard let fields = alert.textFields, fields.count == 3 else { return }
                                            
                                            let currentPasswordField = fields[0]
                                            let newPasswordField = fields[1]
                                            let repeatNewPasswordField = fields[2]
                                            
                                            guard let currentPassword = currentPasswordField.text, !currentPassword.isEmpty,
                                                  let newPassword = newPasswordField.text, !newPassword.isEmpty,
                                                  let repeatNewPassword = repeatNewPasswordField.text, !repeatNewPassword.isEmpty
                                            else {
                                                return self!.triggerNotification(text: "Fill in the fields!")
                                            }
                                            
                                            if currentPassword != masterPassword {
                                                return self!.triggerNotification(text: "Invalid current password")
                                            }
                                            
                                            if newPassword != repeatNewPassword {
                                                return self!.triggerNotification(text: "Passwords do not match!")
                                            }
                                            
                                            KeychainWrapper.standard.set(newPassword, forKey: Keys.masterPassword)
                                            
                                            return self!.triggerNotification(text: "Password changed")
                                        }
                                    )
                                )
                                
                                self?.present(alert, animated: true)
                            }
                    )
                ]
            )
        ]
        
        tableView.frame = view.bounds
    }
    
    private func getCell<T: UITableViewCell>(_: T.Type, identifier: String, indexPath: IndexPath) -> T {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: identifier,
            for: indexPath
        ) as! T
        
        return cell
    }
    
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        
        return section.title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        
        switch model.self {
        case .staticCell(let model):
            let cell = getCell(SettingsTableViewCell.self,
                               identifier: SettingsTableViewCell.identifier,
                               indexPath: indexPath)
            
            cell.configure(with: model)
            
            return cell
        case .switchCell(let model):
            let cell = getCell(SettingsSwitchTableViewCell.self,
                               identifier: SettingsSwitchTableViewCell.identifier,
                               indexPath: indexPath)
            
            cell.configure(with: model)
            cell.completion = model.completion
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let type = models[indexPath.section].options[indexPath.row]
        
        switch type.self {
        case .staticCell(let model):
            model.completion()
        case .switchCell:
            break
        }
    }
    
}
