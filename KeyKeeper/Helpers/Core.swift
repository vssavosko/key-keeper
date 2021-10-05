//
//  Core.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 05.10.2021.
//

import UIKit

class Core {
    
    static let shared = Core()
    
    func isNewUser() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func setIsNotNewUser() {
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
    
}
