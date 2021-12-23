//
//  Language.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 24.12.2021.
//

import UIKit

class Language {
    
    static let shared = Language()
    
    func getLanguage() -> String {
        let languageNumber = UserDefaults.standard.integer(forKey: Keys.language)
        
        switch languageNumber {
        case 1:
            return "ru"
        default:
            return "en"
        }
    }
    
}
