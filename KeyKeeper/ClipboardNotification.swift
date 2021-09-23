//
//  ClipboardNotification.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 23.09.2021.
//

import UIKit

class ClipboardNotification: UIView {
    
    private lazy var notificationView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        view.backgroundColor = .tertiarySystemBackground
        view.layer.cornerRadius = 25
        view.layer.shadowColor = UIColor.systemFill.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 25
        
        return view
    }()
    private let label = Generator.generateLabel(text: "Password copied!",
                                                textAlignment: .center,
                                                font: .systemFont(ofSize: 17, weight: .semibold),
                                                color: .label)
    
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
        notificationView.anchor(top: nil,
                                leading: self.leadingAnchor,
                                bottom: self.bottomAnchor,
                                trailing: self.trailingAnchor,
                                padding: UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 35),
                                size: CGSize(width: 0, height: 55))
        
        label.anchor(top: notificationView.topAnchor,
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
    }
    
    public func dismiss() {
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
