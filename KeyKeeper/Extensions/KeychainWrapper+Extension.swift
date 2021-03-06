//
//  Keychain.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 25.08.2021.
//

import Foundation
import SwiftKeychainWrapper
import Localize_Swift

let keychain: KeychainWrapper = KeychainWrapper.standard

extension KeychainWrapper {
    
    func saveAccounts(_ value: [Account], forKey key: String) {
        guard let data = try? NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false)
        else { fatalError("The data cannot be encoded".localized()) }
        
        self.set(data, forKey: key)
    }
    
    func getAccounts(forKey key: String) -> [Account]? {
        if let storedData = self.data(forKey: key) {
            guard let data = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(storedData) as? [Account]
            else { fatalError("The data cannot be decoded".localized()) }
            
            return data
        }
        
        return nil
    }
    
}
