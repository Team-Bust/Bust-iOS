//
//  MypageViewController.swift
//  Bust-iOS
//
//  Created by KJ on 10/5/24.
//

import UIKit

import Moya
import SnapKit

final class MypageViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let myPageView = MypageView()
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setDelegate()
        setAddTarget()
        
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension MypageViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        self.view.backgroundColor = .white
        
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        self.view.addSubview(myPageView)
        
        myPageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    private func setDelegate() {
        myPageView.myPlaceCollectionView.delegate = self
        myPageView.myPlaceCollectionView.dataSource = self
    }
    
    private func setAddTarget() {
        myPageView.settingButton.addTarget(self, action: #selector(settingButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func settingButtonDidTap() {
        self.navigationController?.pushViewController(SettingViewController(), animated: true)
    }
}

extension MypageViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let recordDetailData = recordData.diaries[indexPath.item]
        self.navigationController?.pushViewController(MyPlaceDetailViewController(), animated: true)
    }
}

extension MypageViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  MyPageListCollectionViewCell.dequeueReusableCell(collectionView: myPageView.myPlaceCollectionView, indexPath: indexPath)
//        cell.bindRecord(recordData.diaries[indexPath.item])
        return cell
    }
}
