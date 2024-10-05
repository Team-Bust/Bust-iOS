//
//  MyPageListCollectionViewCell.swift
//  Bust-iOS
//
//  Created by KJ on 10/5/24.
//

import UIKit

import SnapKit
import Kingfisher

final class MyPageListCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    static var isFromNib = false
    
    private let imageView = UIImageView(image: .imgFood)
    
    private let placeNameLabel = {
        let label = UILabel()
        label.text = "오륙도 스카이워크"
        label.textColor = .black
        label.font = .fontBust(.body2)
        return label
    }()
    
    private let placeAddressLabel = {
        let label = UILabel()
        label.text = "상세 위치: 부산 남구 오륙도로 137"
        label.textColor = .gray400
        label.font = .fontBust(.caption11)
        return label
    }()
    
    private let placeDateLabel = {
        let label = UILabel()
        label.text = "방문 일자: 2024-10-24"
        label.textColor = .mainBlue
        label.font = .fontBust(.caption11)
        return label
    }()
    
    private let rightArrowButton = {
        let button = UIButton()
        button.setImage(.icArrowNextTouch, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MyPageListCollectionViewCell {
     
    func setUI() {
        self.backgroundColor = .gray100
        self.layer.cornerRadius = 8
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
    
    func setHierarchy() {
        addSubviews()
    }
    
    func setLayout() {
        self.addSubviews(imageView, placeNameLabel, placeAddressLabel,
                         placeDateLabel, rightArrowButton)
        
        imageView.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.width.equalTo(86)
        }
        
        placeNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalTo(imageView.snp.trailing).offset(12)
        }
        
        placeAddressLabel.snp.makeConstraints {
            $0.top.equalTo(placeNameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(placeNameLabel)
            $0.trailing.equalToSuperview().inset(52)
        }
        
        placeDateLabel.snp.makeConstraints {
            $0.top.equalTo(placeAddressLabel.snp.bottom).offset(8)
            $0.leading.equalTo(placeNameLabel)
        }
        
        rightArrowButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(8)
        }
    }
}

extension MyPageListCollectionViewCell {
    
    func bindCell(_ data: History) {
        placeNameLabel.text = data.placeName
        placeAddressLabel.text = "상세 위치 : \(data.address)"
        placeDateLabel.text = data.timestamp
        if data.image == "" {
            imageView.image = UIImage(resource: .imgMypageEmpty)
        } else {
            imageView.kf.setImage(with: URL(string: data.image))
            imageView.clipsToBounds = true
            imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            imageView.layer.cornerRadius = 8
        }
    }
}

