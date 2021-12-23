//
//  BaseChecklistTableViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 13.11.2021.
//

import UIKit

class BaseChecklistTableViewController: UIViewController {
    
    internal var options: [ChecklistOptions] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero,
                                    style: .insetGrouped)
        
        tableView.register(ChecklistTableViewCell.self,
                           forCellReuseIdentifier: ChecklistTableViewCell.identifier)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        configureDelegates()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    private func configureDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension BaseChecklistTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let option = options[indexPath.row]
        
        for option in options {
            option.isChecked = false
        }
        
        option.isChecked = true
        
        tableView.reloadData()
    }
    
}
