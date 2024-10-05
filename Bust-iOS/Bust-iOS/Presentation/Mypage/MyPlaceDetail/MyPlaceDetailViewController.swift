//
//  MyPlaceDetailViewController.swift
//  Bust-iOS
//
//  Created by KJ on 10/5/24.
//

import UIKit

import Moya
import SnapKit

final class MyPlaceDetailViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let myPlaceDetailView = MyPlaceDetailView()
    var historyId: Int = 0
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setAddTarget()
        getMypageDetail(id: self.historyId)
        
        navigationController?.navigationBar.isHidden = true
    }
}

extension MyPlaceDetailViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = .white
        
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        self.view.addSubview(myPlaceDetailView)
        
        myPlaceDetailView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    private func setAddTarget() {
        myPlaceDetailView.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func backButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
}

extension MyPlaceDetailViewController {
    
    func getMypageDetail(id: Int) {
        MypageService.shared.getMypageDetail(id: id) { response in
            guard let data = response?.data else { return }
            self.myPlaceDetailView.bindMyplaceDetail(model: data)
        }
    }
}
