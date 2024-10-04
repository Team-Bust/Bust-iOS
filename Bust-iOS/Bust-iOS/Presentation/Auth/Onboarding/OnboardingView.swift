//
//  OnboardingView.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/5/24.
//


import UIKit

import SnapKit

final class OnboardingView: UIView {
    
    // MARK: - UI Components
    
    private let onboardingTitleLabel = {
        let label = UILabel()
        label.text = "반가워요!\n어떤 코스를 좋아하시나요?"
        label.textColor = .black
        label.numberOfLines = 0
        label.asLineHeight(.heading3)
        label.font = .fontBust(.heading3)
        return label
    }()
    
    private let onboardingSubTitleLabel = {
        let label = UILabel()
        label.text = "딱 맞는 취향의 코스를 추천해드려요."
        label.textColor = .gray400
        label.asLineHeight(.body11)
        label.font = .fontBust(.body11)
        return label
    }()
    
    lazy var collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 104, height: 115)
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.register(
            OnboardingCollectionViewCell.self,
            forCellWithReuseIdentifier: OnboardingCollectionViewCell.className
        )
        return cv
    }()
    
    let nextButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundColor(.gray200, for: .disabled)
        button.setBackgroundColor(.mainBlue, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnboardingView {
    
    func setUI() {
        backgroundColor = .white
    }
    
    func setHierarchy() {
        addSubviews(onboardingTitleLabel,
                    onboardingSubTitleLabel,
                    collectionView,
                    nextButton)
    }
    
    func setLayout() {
        onboardingTitleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(64)
            $0.leading.equalToSuperview().inset(20)
        }
        
        onboardingSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(onboardingTitleLabel.snp.bottom).offset(16)
            $0.leading.equalTo(onboardingTitleLabel.snp.leading)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(onboardingSubTitleLabel.snp.bottom).offset(36)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 39)
            $0.height.equalTo(369)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-36)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
            $0.height.equalTo(48)
        }
    }
}
