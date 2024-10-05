//
//  HomePlaceCollectionViewCell.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/5/24.
//

import UIKit

import SnapKit
import Kingfisher

final class HomePlaceCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties
    
    static var isFromNib = false
    
    // MARK: - UI Components
    
    private let placeImageView = UIImageView(image: .chBust)
    
    private let placeBackView = {
        let view = UIView()
        view.backgroundColor = .gray100
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let placeTitleLabel = {
        let label = UILabel()
        label.text = "이름이름"
        label.textColor = .black
        label.asLineHeight(.body2)
        label.font = .fontBust(.body2)
        return label
    }()
    
    private let placeAddressLabel = {
        let label = UILabel()
        label.text = "상세주소상세주소"
        label.textColor = .gray400
        label.asLineHeight(.caption11)
        label.font = .fontBust(.caption11)
        return label
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

private extension HomePlaceCollectionViewCell {
     
    func setUI() {
    }
    
    func setHierarchy() {
        addSubviews(placeImageView, placeBackView)
        placeBackView.addSubviews(placeTitleLabel, placeAddressLabel)
    }
    
    func setLayout() {
        placeImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        placeBackView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(74)
        }
        
        placeTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
        }
        
        placeAddressLabel.snp.makeConstraints {
            $0.top.equalTo(placeTitleLabel.snp.bottom)
            $0.leading.equalTo(placeTitleLabel.snp.leading)
        }
    }
}

extension HomePlaceCollectionViewCell {
    
    func bindHomePlace(model: RecommendedPlace) {
        placeTitleLabel.text = model.title
        placeAddressLabel.text = model.address
        placeImageView.kf.setImage(with: URL(string: model.image))
    }
}
