//
//  LoginView.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/5/24.
//

import UIKit

import SnapKit

final class LoginView: UIView {
    
    // MARK: - UI Components
    
    private let backgroundImageView = UIImageView(image: .graphicSplash)
    private let logoImageView = UIImageView(image: .logo)
    
    private let logoLabel = {
        let label = UILabel()
        label.text = "익숙함을 넘어, 부산의 새로운 길을 탐험하다"
        label.textColor = .mainBlue
        label.asLineHeight(.body1)
        label.font = .fontBust(.body1)
        return label
    }()
    
    private let chImageView = UIImageView(image: .chBust)
    
    let kakaoButton = {
        let button = UIButton()
        button.setImage(.btnLoginKakao, for: .normal)
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

extension LoginView {
    
    func setUI() {
        backgroundColor = .clear
        backgroundImageView.contentMode = .scaleAspectFill
    }
    
    func setHierarchy() {
        addSubviews(backgroundImageView,
                    logoImageView,
                    logoLabel,
                    chImageView,
                    kakaoButton)
    }
    
    func setLayout() {
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(84)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(136)
            $0.height.equalTo(48)
        }
        
        logoLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        chImageView.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-241)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(116)
            $0.height.equalTo(190)
        }
        
        kakaoButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-36)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 41)
            $0.height.equalTo(48)
        }
    }
}
