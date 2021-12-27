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
    private let slideTitleLabel: FormLabel = {
        let label = FormLabel(font: .systemFont(ofSize: 22, weight: .semibold),
                              textColor: .black,
                              text: "")
        
        label.numberOfLines = 0
        
        return label
    }()
    private let slideDescriptionLabel: UILabel = {
        let label = FormLabel(font: .systemFont(ofSize: 14, weight: .semibold),
                              textColor: .black,
                              text: "")
        
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        configureSubviews()
        setupElementConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        slideImageView.image = nil
        slideTitleLabel.text = nil
        slideDescriptionLabel.text = nil
    }
    
    public func configure(slide: OnboardingSlide) {
        slideImageView.image = slide.image
        slideTitleLabel.text = slide.title
        slideDescriptionLabel.text = slide.description
    }
    
    private func configureSubviews() {
        addSubview(slideImageView)
        addSubview(slideTitleLabel)
        addSubview(slideDescriptionLabel)
    }
    
    private func setupElementConstraints() {
        slideImageView.anchor(top: safeAreaLayoutGuide.topAnchor,
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
