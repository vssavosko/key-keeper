//
//  OnboardingCell.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 06.10.2021.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    
    static let identifier = "OnboardingCell"
    
    private let slideImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private let slideTitleLabel = Generator.generateLabel(text: "",
                                                          textColor: .black,
                                                          font: .systemFont(ofSize: 22, weight: .semibold),
                                                          numberOfLines: 0)
    
    private let slideDescriptionLabel = Generator.generateLabel(text: "",
                                                                textColor: .black,
                                                                font: .systemFont(ofSize: 14, weight: .regular),
                                                                numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        configureSubviews()
        
        setupElementConstraints()
    }
    
    func set(slide: OnboardingSlide) {
        slideImageView.image = slide.image
        slideTitleLabel.text = slide.title
        slideDescriptionLabel.text = slide.description
    }
    
    private func configureSubviews() {
        self.addSubview(slideImageView)
        self.addSubview(slideTitleLabel)
        self.addSubview(slideDescriptionLabel)
    }
    
    private func setupElementConstraints() {
        slideImageView.anchor(top: self.safeAreaLayoutGuide.topAnchor,
                              leading: self.leadingAnchor,
                              bottom: slideTitleLabel.topAnchor,
                              trailing: self.trailingAnchor,
                              padding: UIEdgeInsets(top: 70, left: 0, bottom: 30, right: 0))
        
        slideTitleLabel.anchor(top: nil,
                               leading: self.leadingAnchor,
                               bottom: slideDescriptionLabel.topAnchor,
                               trailing: self.trailingAnchor,
                               padding: UIEdgeInsets(top: 0, left: 40, bottom: 15, right: 40))
        
        slideDescriptionLabel.anchor(top: nil,
                                     leading: self.leadingAnchor,
                                     bottom: nil,
                                     trailing: self.trailingAnchor,
                                     padding: UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
