//
//  EnvVars.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 08.09.2021.
//

enum AppMode: String {
    case DEV = "development"
    case PROD = "production"
}

class EnvVars {
    static let shared: EnvVars = EnvVars()
    
    var appMode = "none"
    
    func setUpEnvVars() {
        #if DEV
        self.appMode = AppMode.DEV.rawValue
        #elseif PROD
        self.appMode = AppMode.PROD.rawValue
        #endif
    }
}
