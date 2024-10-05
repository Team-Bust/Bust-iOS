//
//  CheckAnswerView.swift
//  Bust-iOS
//
//  Created by KJ on 10/5/24.
//

import UIKit

import SnapKit

enum AnswerViewType {
    case correctAnswer
    case useTicket
}

final class CheckAnswerView: UIScrollView {
    
    // MARK: - UI Components
    
    private let checkLabel = {
        let label = UILabel()
        label.text = "위치를 찾아\n티켓 1장을 얻었어요!"
        label.textColor = .black
        label.font = .fontBust(.heading3)
        label.numberOfLines = 2
        return label
    }()
    
    private let answerImage = UIImageView(image: .imgActivity)
    
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
    
    let hintView = WriteHintView()
    
    private let contentView = UIView()
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    init(_ type: AnswerViewType) {
        super.init(frame: .zero)
        setUI()
        setLayout()
        
        switch type {
        case .correctAnswer:
            hintView.isHidden = false
        case .useTicket:
            hintView.isHidden = true
            checkLabel.text = "티켓을 사용해\n정답을 확인했어요!"
            contentView.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.leading.trailing.equalToSuperview()
                $0.width.equalTo(self.snp.width)
                $0.bottom.equalTo(descriptionLabel.snp.bottom).offset(40)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CheckAnswerView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        self.backgroundColor = .white
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        self.addSubviews(contentView)
        contentView.addSubviews(checkLabel, answerImage,
                                locationNameLabel, locationDetailLabel,
                           descriptionLabel, hintView)
        
        checkLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().inset(20)
        }
        
        answerImage.snp.makeConstraints {
            $0.top.equalTo(checkLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(216)
        }
        
        locationNameLabel.snp.makeConstraints {
            $0.top.equalTo(answerImage.snp.bottom).offset(20)
            $0.leading.equalTo(checkLabel)
        }
        
        locationDetailLabel.snp.makeConstraints {
            $0.top.equalTo(locationNameLabel.snp.bottom).offset(8)
            $0.leading.equalTo(checkLabel)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(locationDetailLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.width.equalTo(335)
            $0.height.equalTo(130)
        }
        
        hintView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.width.equalTo(self.snp.width)
            $0.bottom.equalTo(hintView.snp.bottom).offset(40)
        }
    }
    
    // MARK: - Methods
     
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentSize = contentView.frame.size
    }
    
    // MARK: - @objc Methods
}
