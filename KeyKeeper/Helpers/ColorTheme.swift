//
//  setColorTheme.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 20.11.2021.
//

import UIKit

class ColorTheme {
    
    static public func setColorTheme(_ window: UIWindow, themeState: Int) {
        switch themeState {
        case 0:
            window.overrideUserInterfaceStyle = .unspecified
            
            break
        case 1:
            window.overrideUserInterfaceStyle = .light
            
            break
        case 2:
            window.overrideUserInterfaceStyle = .dark
            
            break
        default:
            break
        }
    }
    
}
