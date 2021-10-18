//
//  UIViewController+Extensions.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 16.10.2021.
//

import UIKit

extension UIViewController {
    
    func triggerNotification(text: String? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) { [weak self] in
            let clipboardNotification = ClipboardNotification()
            
            if let text = text {
                clipboardNotification.messageLabel.text = text
            }
            
            self?.view.addSubview(clipboardNotification)
            
            if let completion = completion {
                completion()
            }
        }
    }
    
}
