//
//  SettingsViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 25.07.2021.
//

import UIKit

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
                            iconBackgroundColor: .clear) {
                                print("yo Change language")
                            }
                    ),
                    .staticCell(
                        model: SettingsOption(
                            title: "Change color theme",
                            icon: nil,
                            iconBackgroundColor: .clear) {
                                print("yo Change color theme")
                            }
                    ),
                    .staticCell(
                        model: SettingsOption(
                            title: "Change Master Password",
                            icon: nil,
                            iconBackgroundColor: .clear) {
                                print("yo Change Master Password")
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
