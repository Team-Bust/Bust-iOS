//
//  MypageView.swift
//  Bust-iOS
//
//  Created by KJ on 10/5/24.
//

import UIKit

import SnapKit

final class MypageView: UIView {
    
    // MARK: - UI Components
    
    private let myProfileView = {
        let view = UIView()
        view.backgroundColor = .lightBlue
        return view
    }()
    
    private let myProfileLabel = {
        let label = UILabel()
        label.text = "나의 프로필"
        label.textColor = .black
        label.font = .fontBust(.subtitle1)
        return label
    }()
    
    let settingButton = {
        let button = UIButton()
        button.setImage(.icSetting, for: .normal)
        return button
    }()
    
    private let profileImageView = UIImageView(image: .imgProfile)
    
    private let userNameLabel = {
        let label = UILabel()
        label.text = "\(UserManager.shared.getUsername) 님"
        label.textColor = .mainBlue
        label.font = .fontBust(.body1)
        return label
    }()
    
    private let myPlaceListView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let myPlaceLabel = {
        let label = UILabel()
        label.text = "나의 장소리스트"
        label.font = .fontBust(.subtitle1)
        label.textColor = .black
        return label
    }()
    
    lazy var myPlaceCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: SizeLiterals.Screen.screenWidth - 40, height: 96)
        layout.minimumInteritemSpacing = 12
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.register(
            MyPageListCollectionViewCell.self,
            forCellWithReuseIdentifier: MyPageListCollectionViewCell.className
        )
        return cv
    }()
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MypageView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        self.backgroundColor = .clear
        
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        addSubviews(myProfileView, myPlaceListView)
        myProfileView.addSubviews(myProfileLabel, settingButton, profileImageView, userNameLabel)
        myPlaceListView.addSubviews(myPlaceLabel, myPlaceCollectionView)
        
        myProfileView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(284)
        }
        
        myProfileLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(20)
            $0.leading.equalToSuperview().inset(20)
        }
        
        settingButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(8)
            $0.trailing.equalToSuperview().inset(6)
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(settingButton.snp.bottom).offset(8)
            $0.size.equalTo(110)
            $0.centerX.equalToSuperview()
        }
        
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        myPlaceListView.snp.makeConstraints {
            $0.top.equalTo(myProfileView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        myPlaceLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
        }
        
        myPlaceCollectionView.snp.makeConstraints {
            $0.top.equalTo(myPlaceLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(12)
        }
    }
    
    // MARK: - Methods
    
    // MARK: - @objc Methods
}
