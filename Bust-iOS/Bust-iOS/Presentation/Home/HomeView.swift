//
//  HomeView.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/5/24.
//

import UIKit

import SnapKit

final class HomeView: UIView {
    
    // MARK: - UI Components
    
    private let logoImageView = UIImageView(image: .logo)
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let homeStatusView = {
        let view = UIView()
        view.backgroundColor = .gray100
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let homeStatusTitle = {
        let label = UILabel()
        label.text = "나의 현황"
        label.textColor = .black
        label.asLineHeight(.subtitle1)
        label.font = .fontBust(.subtitle1)
        return label
    }()
    
    // ticket
    
    private let ticketBackView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 4
        return view
    }()
    
    private let ticketImageView = UIImageView(image: .icTicket)
    
    private let ticketTitleLabel = {
        let label = UILabel()
        label.text = "티켓"
        label.textColor = .black
        label.asLineHeight(.caption11)
        label.font = .fontBust(.caption11)
        return label
    }()
    
    private let ticketDetailLabel = {
        let label = UILabel()
        label.textColor = .bustGreen
        label.font = .fontBust(.body2)
        return label
    }()
    
    // grade
    
    private let gradeBackView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 4
        return view
    }()
    
    private let gradeImageView = UIImageView(image: .icStar)
    
    private let gradeTitleLabel = {
        let label = UILabel()
        label.text = "등급"
        label.textColor = .black
        label.asLineHeight(.caption11)
        label.font = .fontBust(.caption11)
        return label
    }()
    
    private let gradeDetailLabel = {
        let label = UILabel()
        label.textColor = .bustYellow
        label.font = .fontBust(.body2)
        return label
    }()
    
    // correct
    
    private let correctBackView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 4
        return view
    }()
    
    private let correctImageView = UIImageView(image: .icMap)
    
    private let correctTitleLabel = {
        let label = UILabel()
        label.text = "맞춘 위치"
        label.textColor = .black
        label.asLineHeight(.caption11)
        label.font = .fontBust(.caption11)
        return label
    }()
    
    private let correctDetailLabel = {
        let label = UILabel()
        label.textColor = .bustOrange
        label.font = .fontBust(.body2)
        return label
    }()
    
    let missionStartButton = {
        let button = UIButton()
        button.setImage(.btnMissionStart, for: .normal)
        button.setImage(.btnMissionStart, for: .selected)
        return button
    }()
    
    let registerPlaceButton = {
        let button = UIButton()
        button.setImage(.btnRegisterPlace, for: .normal)
        button.setImage(.btnRegisterPlace, for: .selected)
        return button
    }()
    
    private let placeTitleLabel = {
        let label = UILabel()
        label.text = "부산의 새로운 매력, 이곳은 어때요?"
        label.textColor = .black
        label.asLineHeight(.subtitle1)
        label.font = .fontBust(.subtitle1)
        return label
    }()
    
    lazy var collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: SizeLiterals.Screen.screenWidth - 40, height: 172)
        layout.minimumLineSpacing = 14
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.isScrollEnabled = false
        cv.register(
            HomePlaceCollectionViewCell.self,
            forCellWithReuseIdentifier: HomePlaceCollectionViewCell.className
        )
        return cv
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

extension HomeView {
    
    func setUI() {
        backgroundColor = .white
    }
    
    func setHierarchy() {
        addSubviews(logoImageView, scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(homeStatusView, missionStartButton, registerPlaceButton, placeTitleLabel, collectionView)
        homeStatusView.addSubviews(homeStatusTitle, ticketBackView, gradeBackView, correctBackView)
        ticketBackView.addSubviews(ticketImageView, ticketTitleLabel, ticketDetailLabel)
        gradeBackView.addSubviews(gradeImageView, gradeTitleLabel, gradeDetailLabel)
        correctBackView.addSubviews(correctImageView, correctTitleLabel, correctDetailLabel)
    }
    
    func setLayout() {
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(20)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(74)
            $0.height.equalTo(26)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView.snp.width)
            $0.height.equalTo(scrollView.snp.height).priority(.low)
        }
        
        homeStatusView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
            $0.height.equalTo(165)
        }
        
        homeStatusTitle.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
        }
        
        ticketBackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
        }
        
        correctBackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
        }
        
        gradeBackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        [ticketBackView, gradeBackView, correctBackView].forEach {
            $0.snp.makeConstraints {
                $0.width.equalTo(SizeLiterals.Screen.screenWidth * 92 / 375)
                $0.height.equalTo(97)
                $0.bottom.equalToSuperview().inset(16)
            }
        }
        
        [ticketImageView, gradeImageView, correctImageView].forEach {
            $0.snp.makeConstraints {
                $0.top.equalToSuperview().inset(10)
                $0.centerX.equalToSuperview()
                $0.size.equalTo(32)
            }
        }
        
        ticketTitleLabel.snp.makeConstraints {
            $0.top.equalTo(ticketImageView.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        
        ticketDetailLabel.snp.makeConstraints {
            $0.top.equalTo(ticketTitleLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        gradeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(gradeImageView.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        
        gradeDetailLabel.snp.makeConstraints {
            $0.top.equalTo(gradeTitleLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        correctTitleLabel.snp.makeConstraints {
            $0.top.equalTo(correctImageView.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        
        correctDetailLabel.snp.makeConstraints {
            $0.top.equalTo(correctTitleLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        missionStartButton.snp.makeConstraints {
            $0.top.equalTo(homeStatusView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo((SizeLiterals.Screen.screenWidth - 45) / 2)
            $0.height.equalTo(136)
        }
        
        registerPlaceButton.snp.makeConstraints {
            $0.top.equalTo(homeStatusView.snp.bottom).offset(16)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo((SizeLiterals.Screen.screenWidth - 45) / 2)
            $0.height.equalTo(136)
        }
        
        placeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(missionStartButton.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(20)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(placeTitleLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
            $0.height.equalTo(584)
            $0.bottom.equalToSuperview()
        }
    }
    
    func bindHomeView(dto: HomeInfoResponseDto) {
        ticketDetailLabel.text = "\(dto.tickets)장"
        gradeDetailLabel.text = dto.grade
        correctDetailLabel.text = "\(dto.gameCount)개"
    }
}
