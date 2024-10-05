//
//  WriteHintView.swift
//  Bust-iOS
//
//  Created by KJ on 10/5/24.
//

import UIKit

import SnapKit

final class WriteHintView: UIView {
    
    // MARK: - UI Components
    
    private let hintLabel = {
        let label = UILabel()
        label.text = "힌트 작성"
        label.font = .fontBust(.body1)
        label.textColor = .mainBlue
        return label
    }()
    
    private let hintDescriptionLabel = {
        let label = UILabel()
        label.text = "힌트를 작성해 주시면 티켓을 한 장 더 드려요!"
        label.font = .fontBust(.body21)
        label.textColor = .gray500
        return label
    }()
    
    private let hintTextField = {
        let textField = UITextField()
        textField.backgroundColor = .gray100
        textField.placeholder = "힌트를 작성해주세요."
        textField.font = .fontBust(.body11)
        textField.textColor = .gray300
        textField.setLeftPaddingPoints(16)
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        return textField
    }()
    
    private let warningLabel = {
        let label = UILabel()
        label.text = "* 직접적인 상호명, 장소 이름이 노출될 경우 사용되지 않습니다."
        label.font = .fontBust(.caption11)
        label.textColor = .gray300
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

extension WriteHintView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        self.backgroundColor = .white
        
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        addSubviews(hintLabel, hintDescriptionLabel,
                    hintTextField, warningLabel)
        
        hintLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        hintDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(hintLabel.snp.bottom).offset(8)
            $0.leading.equalTo(hintLabel)
        }
        
        hintTextField.snp.makeConstraints {
            $0.top.equalTo(hintDescriptionLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        
        warningLabel.snp.makeConstraints {
            $0.top.equalTo(hintTextField.snp.bottom).offset(4)
            $0.leading.equalTo(hintLabel)
        }
    }
    
    // MARK: - Methods
    
    // MARK: - @objc Methods
}
