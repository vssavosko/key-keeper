//
//  ClipboardNotification.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 23.09.2021.
//

import UIKit
import Localize_Swift

class ClipboardNotification: UIView {
    
    private let dispatchAfter = DispatchTimeInterval.seconds(2)
    
    private lazy var notificationView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(messageLabel)
        
        view.backgroundColor =  .systemGray6
        view.layer.cornerRadius = 25
        
        return view
    }()
    var messageLabel = Generator.generateLabel(text: "Password copied".localized(),
                                               textAlignment: .center,
                                               textColor: .label,
                                               font: .systemFont(ofSize: 13, weight: .semibold))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        animateIn()
    }
    
    private func configureView() {
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 143)
        
        self.addSubview(notificationView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        notificationView.anchor(top: self.topAnchor,
                                leading: self.leadingAnchor,
                                bottom: nil,
                                trailing: self.trailingAnchor,
                                padding: UIEdgeInsets(top: 40, left: 45, bottom: 0, right: 45),
                                size: CGSize(width: 0, height: 50))
        
        messageLabel.anchor(top: notificationView.topAnchor,
                            leading: notificationView.leadingAnchor,
                            bottom: notificationView.bottomAnchor,
                            trailing: notificationView.trailingAnchor)
    }
    
    private func animateIn() {
        self.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
        self.alpha = 0
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseIn) {
            self.transform = .identity
            self.alpha = 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + dispatchAfter) {
            self.dismiss()
        }
    }
    
    private func dismiss() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseIn) {
            self.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
            self.alpha = 0
        } completion: { (complete) in
            if complete {
                self.removeFromSuperview()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
