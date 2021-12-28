//
//  FormStackView.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 27.12.2021.
//

import UIKit

class FormStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        spacing = 10.0
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
