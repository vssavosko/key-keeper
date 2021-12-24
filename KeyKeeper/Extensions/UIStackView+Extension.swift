//
//  StackView+Extension.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 25.12.2021.
//

import UIKit

extension UIStackView {
    
    func addBottomLine(backgroundColor: UIColor = UIColor.systemBackground,
                       lineColor: UIColor = .systemGray5) {
        self.layer.backgroundColor = backgroundColor.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = lineColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
}
