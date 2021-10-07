//
//  Core.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 05.10.2021.
//

import UIKit

class Core {
    
    static let shared = Core()
    
    func isFirstLaunch() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isFirstLaunch")
    }
    
    func setIsNotFirstLaunch() {
        UserDefaults.standard.set(true, forKey: "isFirstLaunch")
    }
    
}
