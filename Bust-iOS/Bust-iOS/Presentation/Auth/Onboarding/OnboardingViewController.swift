//
//  OnboardingViewController.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/5/24.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
    private let onboardingView = OnboardingView()
    private lazy var cv = onboardingView.collectionView
    private let model = OnboardingMenuModel.onboardingMenuData()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = onboardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
    }
}

extension OnboardingViewController {
    
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setDelegate() {
        cv.delegate = self
        cv.dataSource = self
    }
    
    func setAddTarget() {
        onboardingView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func nextButtonTapped() {
//        UserManager.shared.updateOnboarding()
//        let nav = TabBarController()
//        self.navigationController?.pushViewController(nav, animated: true)
    }
}


extension OnboardingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedCell = collectionView.cellForItem(at: indexPath) as? OnboardingCollectionViewCell {
            selectedCell.isSelected = true
        }
        
        if let previouslySelectedIndexPath = collectionView.indexPathsForSelectedItems?.first, previouslySelectedIndexPath != indexPath {
            if let previousCell = collectionView.cellForItem(at: previouslySelectedIndexPath) as? OnboardingCollectionViewCell {
                previousCell.isSelected = false
            }
        }
        
        onboardingView.nextButton.isEnabled = true
    }
}

extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = OnboardingCollectionViewCell.dequeueReusableCell(collectionView: cv,
                                                                    indexPath: indexPath)
        cell.bindOnboarding(model: model[indexPath.item])
        return cell
    }
}
