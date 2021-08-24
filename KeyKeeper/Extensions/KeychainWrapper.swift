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
        self.set(NSKeyedArchiver.archivedData(withRootObject: value),
                 forKey: key)
    }
    
    func getAccounts(forKey key: String) -> [Account]? {
        if let storedData = self.data(forKey: key) {
            return NSKeyedUnarchiver.unarchiveObject(with: storedData) as? [Account]
        }
        return nil
    }
    
}
