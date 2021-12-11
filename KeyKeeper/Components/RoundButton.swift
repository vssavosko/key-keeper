//
//  RoundButton.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 11.12.2021.
//

import UIKit

class RoundButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(text: String) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(text, for: .normal)
        setTitleColor(.systemBlue, for: .normal)
        layer.cornerRadius = 25
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
