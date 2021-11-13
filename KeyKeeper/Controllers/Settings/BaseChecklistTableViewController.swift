//
//  BaseChecklistTableViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 13.11.2021.
//

import UIKit

class BaseChecklistTableViewController: UIViewController {
    
    internal var items: [ChecklistOption] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ChecklistTableViewCell")
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
}

extension BaseChecklistTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistTableViewCell", for: indexPath)
        
        cell.textLabel?.text = item.title
        cell.accessoryType = item.isChecked ? .checkmark : .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = items[indexPath.row]
        
        for item in items {
            item.isChecked = false
        }
        
        item.isChecked = true
        
        tableView.reloadData()
    }
    
}
