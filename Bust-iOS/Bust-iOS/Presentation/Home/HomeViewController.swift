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
    private var homeInfoData = HomeInfoResponseDto(username: "", tickets: 0, grade: "", gameCount: 0, recommendedPlaces: [])
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getHomeInfo()
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
            self.getHomeGame()
            self.tabBarController?.selectedIndex = 1
        case homeView.registerPlaceButton:
            let nav = AddLocationViewController()
            nav.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(nav, animated: true)
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
        if homeInfoData.recommendedPlaces.count > 0 {
            cell.bindHomePlace(model: homeInfoData.recommendedPlaces[indexPath.item])
        }
        return cell
    }
}

extension HomeViewController {
    
    func getHomeInfo() {
        HomeService.shared.getHomeInfo { response in
            guard let data = response?.data else { return }
            self.homeInfoData = data
            self.homeView.bindHomeView(dto: data)
            self.cv.reloadData()
        }
    }
    
    func getHomeGame() {
        HomeService.shared.getHomeGame {  response in
            guard (response?.data) != nil else { return }
        }
    }
}
