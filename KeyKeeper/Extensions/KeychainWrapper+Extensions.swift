//
//  Keychain.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 25.08.2021.
//

import Foundation
import SwiftKeychainWrapper

let keychain: KeychainWrapper = KeychainWrapper.standard

extension KeychainWrapper {
    
    func saveAccounts(_ value: [Account], forKey key: String) {
        guard let data = try? NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false)
        else { fatalError("The data cannot be encoded") }
        
        self.set(data, forKey: key, isSynchronizable: EnvVars.shared.appMode != "development")
    }
    
    func getAccounts(forKey key: String) -> [Account]? {
        if let storedData = self.data(forKey: key) {
            guard let data = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(storedData) as? [Account]
            else { fatalError("The data cannot be decoded") }
            
            return data
        }
        
        return nil
    }
    
}
