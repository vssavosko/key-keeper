//
//  WelcomeViewController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 05.10.2021.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    private var slides = [
        OnboardingSlide(title: "Strictly confidential", description: "The vault is protected by world encryption level. How safe is it that even we does not have access to your data.", image: #imageLiteral(resourceName: "shield_eye")),
        OnboardingSlide(title: "Reliable and safe", description: "All the information you add to the app is encrypted and stored only on your device.", image: #imageLiteral(resourceName: "cloud_lock")),
        OnboardingSlide(title: "There is nothing more to forget", description: "You only remember one Master Password and the app remembers all the others!", image: #imageLiteral(resourceName: "fingerprint"))
    ]
    
    private var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            
            if currentPage == slides.count - 1 {
                button.setTitle("Get Started", for: .normal)
            } else {
                button.setTitle("Next", for: .normal)
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
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .systemBlue
        pageControl.pageIndicatorTintColor = .black
        
        return pageControl
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 15
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        pageControl.numberOfPages = slides.count
        
        configureSubviews()
        configureCollectionView()
        setupConstraints()
    }
    
    func configureSubviews() {
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(button)
    }
    
    func configureCollectionView() {
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        setupCollectionViewConstraints()
    }
    
    func setupCollectionViewConstraints() {
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              leading: view.leadingAnchor,
                              bottom: pageControl.topAnchor,
                              trailing: view.trailingAnchor,
                              padding: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
    }
    
    func setupConstraints() {
        pageControl.anchor(top: nil,
                           leading: view.leadingAnchor,
                           bottom: button.topAnchor,
                           trailing: view.trailingAnchor,
                           padding: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
        
        button.anchor(top: nil,
                      leading: view.leadingAnchor,
                      bottom: view.bottomAnchor,
                      trailing: view.trailingAnchor,
                      padding: UIEdgeInsets(top: 0, left: 50, bottom: 50, right: 50),
                      size: CGSize(width: 0, height: 50))
    }
    
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.identifier, for: indexPath) as! OnboardingCell
        let currentSlide = slides[indexPath.row]
        
        cell.set(slide: currentSlide)
        
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
