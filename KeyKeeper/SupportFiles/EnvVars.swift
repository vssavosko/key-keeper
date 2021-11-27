//
//  EnvVars.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 08.09.2021.
//

class EnvVars {
    
    static let shared: EnvVars = EnvVars()
    
    var appMode = "none"
    
    func setUpEnvVars() {
        #if DEV
        self.appMode = AppModeEnum.DEV.rawValue
        #elseif PROD
        self.appMode = AppModeEnum.PROD.rawValue
        #endif
    }
    
}
