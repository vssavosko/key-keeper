//
//  WelcomeViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 05.10.2021.
//

import UIKit
import SwiftKeychainWrapper
import Localize_Swift

class OnboardingViewController: UIViewController {
    
    private var slides = [
        OnboardingSlide(image: #imageLiteral(resourceName: "shield_eye"),
                        title: "Strictly confidential".localized(),
                        description: "All your passwords are securely protected. It is so secure that even we don not have access to your data.".localized()),
        OnboardingSlide(image: #imageLiteral(resourceName: "cloud_lock"),
                        title: "Reliable and safe".localized(),
                        description: "All data that you enter into the vault is encrypted and stored only on your device.".localized()),
        OnboardingSlide(image: #imageLiteral(resourceName: "fingerprint"),
                        title: "There is nothing more to forget".localized(),
                        description: "You only remember one Master Password and the app remembers all the others.".localized())
    ]
    
    private var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            
            if currentPage == slides.count - 1 {
                onboardingNextButton.setTitle("Set the master password".localized(), for: .normal)
            } else {
                onboardingNextButton.setTitle("Next".localized(), for: .normal)
            }
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = slides.count
        pageControl.pageIndicatorTintColor = .black
        pageControl.currentPageIndicatorTintColor = .systemBlue
        
        return pageControl
    }()
    
    private let onboardingNextButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next".localized(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 25
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureSubviews()
        configureElements()
    }
    
    private func configureSubviews() {
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(onboardingNextButton)
    }
    
    private func configureElements() {
        pageControl.addTarget(self, action: #selector(tapOnPageControl), for: .valueChanged)
        onboardingNextButton.addTarget(self, action: #selector(tapOnOnboardingNextButton), for: .touchUpInside)
        
        configureCollectionView()
        
        setupElementConstraints()
    }
    
    private func configureCollectionView() {
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
    }
    
    private func setupElementConstraints() {
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              leading: view.leadingAnchor,
                              bottom: pageControl.topAnchor,
                              trailing: view.trailingAnchor,
                              padding: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
        
        pageControl.anchor(top: nil,
                           leading: view.leadingAnchor,
                           bottom: onboardingNextButton.topAnchor,
                           trailing: view.trailingAnchor,
                           padding: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
        
        onboardingNextButton.anchor(top: nil,
                                    leading: view.leadingAnchor,
                                    bottom: view.bottomAnchor,
                                    trailing: view.trailingAnchor,
                                    padding: UIEdgeInsets(top: 0, left: view.frame.width / 5, bottom: 50, right: view.frame.width / 5),
                                    size: CGSize(width: 0, height: 50))
    }
    
    private func scrollTo(page: Int) {
        let indexPath = IndexPath(item: page, section: 0)
        
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func tapOnPageControl(_ sender: UIPageControl) {
        currentPage = sender.currentPage
        
        scrollTo(page: sender.currentPage)
    }
    
    @objc private func tapOnOnboardingNextButton() {
        if currentPage == slides.count - 1 {
            let masterPasswordVC = MasterPasswordViewController()
            
            masterPasswordVC.completion = { [weak self] (masterPassword: String) in
                Core.shared.setIsNotFirstLaunch()
                
                KeychainWrapper.standard.set(masterPassword, forKey: Keys.masterPassword)
                
                self?.dismiss(animated: true)
            }
            
            present(masterPasswordVC, animated: true)
        } else {
            currentPage += 1
            
            scrollTo(page: currentPage)
        }
    }
    
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.identifier, for: indexPath) as! OnboardingCell
        let currentSlide = slides[indexPath.row]
        
        cell.configure(slide: currentSlide)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        
        currentPage = Int(scrollView.contentOffset.x / width)
    }
    
}
