//
//  SettingsViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 25.07.2021.
//

import UIKit

struct Section {
    
    let title: String
    let options: [SettingsOptionType]
    
}

enum SettingsOptionType {
    
    case staticCell(model: SettingsOption)
    case switchCell(model: SettingsSwitchOption)
    
}

struct SettingsSwitchOption {
    
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
    var isOn: Bool
    
}

struct SettingsOption {
    
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
    
}

class SettingsViewController: UIViewController {
    
    var models = [Section]()
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero,
                                style: .grouped)
        
        table.register(SettingsTableViewCell.self,
                       forCellReuseIdentifier: SettingsTableViewCell.identifier)
        
        table.register(SwitchTableViewCell.self,
                       forCellReuseIdentifier: SwitchTableViewCell.identifier)
        
        table.clipsToBounds = true
        table.layer.cornerRadius = 20
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureNavigationBar()
        configureSubviews()
        setupDelegates()
        configureElements()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Settings"
    }
    
    private func configureSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureElements() {
        self.models.append(
            Section(
                title: "PERIODICALLY REQUESTED FOR SECURITY",
                options: [
                    .switchCell(
                        model: SettingsSwitchOption(
                            title: "Touch ID / Face ID",
                            icon: .init(systemName: "house"),
                            iconBackgroundColor: .systemPink,
                            handler: {
                                print("yo Touch ID / Face ID")
                            },
                            isOn: false
                        )
                    )
                ]
            )
        )
        
        self.models.append(
            Section(
                title: "CLEAR THE CLIPBOARD AFTER 30 SECONDS",
                options: [
                    .switchCell(
                        model: SettingsSwitchOption(
                            title: "Clear the clipboard",
                            icon: .init(systemName: "house"),
                            iconBackgroundColor: .systemPink,
                            handler: {
                                print("yo Touch ID / Face ID")
                            },
                            isOn: false
                        )
                    )
                ]
            )
        )
        
        self.models.append(
            Section(
                title: "Other",
                options: [
                    .staticCell(
                        model: SettingsOption(
                            title: "Change color theme",
                            icon: .init(systemName: "house"),
                            iconBackgroundColor: .systemPink) {
                                print("yo Clear the clipboard")
                            }
                    ),
                    .staticCell(
                        model: SettingsOption(
                            title: "Change language",
                            icon: .init(systemName: "house"),
                            iconBackgroundColor: .systemPink) {
                                print("yo Clear the clipboard")
                            }
                    ),
                    .staticCell(
                        model: SettingsOption(
                            title: "Change Master Password",
                            icon: .init(systemName: "house"),
                            iconBackgroundColor: .systemPink) {
                                print("yo Clear the clipboard")
                            }
                    )
                ]
            )
        )
        
        tableView.frame = view.bounds
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
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingsTableViewCell.identifier,
                for: indexPath
            ) as? SettingsTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: model)
            
            return cell
        case .switchCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SwitchTableViewCell.identifier,
                for: indexPath
            ) as? SwitchTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: model)
            cell.completion = {
                print("test")
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let type = models[indexPath.section].options[indexPath.row]
        
        switch type.self {
        case .staticCell(let model):
            model.handler()
        case .switchCell:
            break
        }
    }
    
}
