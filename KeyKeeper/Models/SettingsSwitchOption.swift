//
//  SettingsSwitchOption.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 12.11.2021.
//

import UIKit

struct SettingsSwitchOption {
    
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    var isOn: Bool
    let completion: (() -> Void)
    
}
