//
//  BottomLine.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 10.12.2021.
//

import UIKit

class BottomLine {
    
    static func generateFor<T: UIView>(element: T,
                                       backgroundColor: UIColor = UIColor.systemBackground,
                                       lineColor: UIColor = .systemGray5) {
        element.layer.backgroundColor = backgroundColor.cgColor
        element.layer.masksToBounds = false
        element.layer.shadowColor = lineColor.cgColor
        element.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        element.layer.shadowOpacity = 1.0
        element.layer.shadowRadius = 0.0
    }
    
}
