//
//  MyPlaceDetailView.swift
//  Bust-iOS
//
//  Created by KJ on 10/5/24.
//

import UIKit

import SnapKit
import Kingfisher

final class MyPlaceDetailView: UIView {
    
    // MARK: - UI Components
    
    private let navigationBar = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let backButton = {
        let button = UIButton()
        button.setImage(.icArrowBackTouch, for: .normal)
        return button
    }()
    
    private let placeImageView = UIImageView(image: .imgNight)
    
    private let locationNameLabel = {
        let label = UILabel()
        label.text = "장소 이름"
        label.font = .fontBust(.title1)
        label.textColor = .black
        return label
    }()
    
    private let locationDetailLabel = {
        let label = UILabel()
        label.text = "상세 위치: 경기도 의정부시 어쩌구"
        label.font = .fontBust(.body21)
        label.textColor = .black
        return label
    }()
    
    private let descriptionLabel = {
        let label = UILabel()
        label.text = """
                    아라야 ! 나랑 놀고 싶어도 그렇지 어떻게 꿈에서까지 나올 수 있니ㅣ?\n이바보 바보~~~~~\n
                    우하하우히히 우하 하아후아후아
                    """
        label.font = .fontBust(.body11)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let myHintLabel = {
        let label = UILabel()
        label.text = "내가 작성한 힌트"
        label.font = .fontBust(.body1)
        label.textColor = .mainBlue
        return label
    }()
    
    private let myHintView = {
        let view = UIView()
        view.backgroundColor = .gray100
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    private let myHintTextLabel = {
        let label = UILabel()
        label.text = "나의 힌트"
        label.font = .fontBust(.body11)
        label.textColor = .black
        return label
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

extension MyPlaceDetailView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        navigationBar.addSubview(backButton)
        myHintView.addSubview(myHintTextLabel)
        
        addSubviews(navigationBar, placeImageView, locationNameLabel, locationDetailLabel,
                    descriptionLabel, myHintLabel, myHintView)
        
        navigationBar.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        backButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        placeImageView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(216)
        }
        
        locationNameLabel.snp.makeConstraints {
            $0.top.equalTo(placeImageView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
        }
        
        locationDetailLabel.snp.makeConstraints {
            $0.top.equalTo(locationNameLabel.snp.bottom).offset(8)
            $0.leading.equalTo(locationNameLabel)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(locationDetailLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.width.equalTo(335)
            $0.height.equalTo(setDescriptionHeight(descriptionLabel.text ?? ""))
        }
        
        myHintLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(30)
            $0.leading.equalTo(locationNameLabel)
        }
        
        myHintView.snp.makeConstraints {
            $0.top.equalTo(myHintLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        
        myHintTextLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - Methods
    
    private func setDescriptionHeight(_ text: String) -> Int {
        let string = text
        let viewSize = Int(string.size(withAttributes: [NSAttributedString.Key.font: UIFont.fontBust(.body11)]).height + 5)
        return viewSize
    }
    
    // MARK: - @objc Methods
}

extension MyPlaceDetailView {
    
    func bindMyplaceDetail(model: MypageDetailResponseDto) {
        locationNameLabel.text = model.history.placeName
        locationDetailLabel.text = "상세 위치 : \(model.history.address)"
        locationDetailLabel.asLineHeight(.body21)
        descriptionLabel.text = model.history.description
        if model.history.image == "" {
            placeImageView.image = UIImage(resource: .imgLocationEmpty)
        } else {
            placeImageView.kf.setImage(with: URL(string: model.history.image))
        }
        myHintTextLabel.text = model.history.hint
    }
}
