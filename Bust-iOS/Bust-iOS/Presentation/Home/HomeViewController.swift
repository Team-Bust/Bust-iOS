//
//  HomeViewController.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/5/24.
//

import UIKit

import SnapKit

final class HomeViewController: UIViewController {
    
    private let homeView = HomeView()
    private lazy var cv = homeView.collectionView
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setAddTarget()
        setDelegate()
    }
}

extension HomeViewController {
    
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setAddTarget() {
        homeView.missionStartButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        homeView.registerPlaceButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc
    func buttonTapped(_ sender: UIButton) {
        switch sender {
        case homeView.missionStartButton:
            print("missionStartButton")
        case homeView.registerPlaceButton:
            print("registerPlaceButton")
        default:
            break
        }
    }
    
    func setDelegate() {
        cv.delegate = self
        cv.dataSource = self
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = HomePlaceCollectionViewCell.dequeueReusableCell(collectionView: cv,
                                                                   indexPath: indexPath)
        return cell
    }
}
