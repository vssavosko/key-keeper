//
//  Account.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 25.07.2021.
//

import UIKit

class Account: NSObject, NSCoding {
    
    var title: String
    var login: String
    var password: String
    var website: String
    var createdAt: String
    var updatedAt: String
    
    func encode(with coder: NSCoder) {
        coder.encode(title, forKey: "title")
        coder.encode(login, forKey: "login")
        coder.encode(password, forKey: "password")
        coder.encode(website, forKey: "website")
        coder.encode(createdAt, forKey: "createdAt")
        coder.encode(updatedAt, forKey: "updatedAt")
    }
    
    required init?(coder: NSCoder) {
        title = coder.decodeObject(forKey: "title") as? String ?? ""
        login = coder.decodeObject(forKey: "login") as? String ?? ""
        password = coder.decodeObject(forKey: "password") as? String ?? ""
        website = coder.decodeObject(forKey: "website") as? String ?? ""
        createdAt = coder.decodeObject(forKey: "createdAt") as? String ?? ""
        updatedAt = coder.decodeObject(forKey: "updatedAt") as? String ?? ""
    }
    
    init(title: String, login: String, password: String, website: String, createdAt: String, updatedAt: String) {
        self.title = title
        self.login = login
        self.password = password
        self.website = website
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
}
