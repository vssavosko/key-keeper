//
//  UniversalButton.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 27.12.2021.
//

import UIKit

class UniversalButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(systemImageName: String) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        setImage(UIImage(systemName: systemImageName), for: .normal)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
