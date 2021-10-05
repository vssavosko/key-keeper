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
    
    private let slideTitleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 0
        
        return label
    }()
    
    private let slideDescriptionLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        
        configureSubviews()
        configureElements()
    }
    
    func set(slide: OnboardingSlide) {
        slideImageView.image = slide.image
        slideTitleLabel.text = slide.title
        slideDescriptionLabel.text = slide.description
    }
    
    func configureSubviews() {
        contentView.addSubview(slideImageView)
        contentView.addSubview(slideTitleLabel)
        contentView.addSubview(slideDescriptionLabel)
    }
    
    func configureElements() {
        setupConstraints()
    }
    
    func setupConstraints() {
        slideImageView.anchor(top: contentView.safeAreaLayoutGuide.topAnchor,
                              leading: contentView.leadingAnchor,
                              bottom: slideTitleLabel.topAnchor,
                              trailing: contentView.trailingAnchor,
                              padding: UIEdgeInsets(top: 70, left: 0, bottom: 30, right: 0))
        
        slideTitleLabel.anchor(top: nil,
                               leading: contentView.leadingAnchor,
                               bottom: slideDescriptionLabel.topAnchor,
                               trailing: contentView.trailingAnchor,
                               padding: UIEdgeInsets(top: 0, left: 40, bottom: 15, right: 40))
        
        slideDescriptionLabel.anchor(top: nil,
                                     leading: contentView.leadingAnchor,
                                     bottom: nil,
                                     trailing: contentView.trailingAnchor,
                                     padding: UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
