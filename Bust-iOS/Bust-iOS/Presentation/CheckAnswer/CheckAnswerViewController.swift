//
//  CheckAnswerViewController.swift
//  Bust-iOS
//
//  Created by KJ on 10/5/24.
//

import UIKit

import Moya
import SnapKit

final class CheckAnswerViewController: UIViewController {
    
    // MARK: - UI Components

    private let checkAnswerView = {
        let view = CheckAnswerView(.useTicket)
        view.isScrollEnabled = true
        view.showsVerticalScrollIndicator = true  // 세로 스크롤 표시
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    private let checkButton = {
        let button = CheckButton()
        button.setTitle("확인", for: .normal)
        button.setState(.allow)
        return button
    }()
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        
        navigationController?.navigationBar.isHidden = true
    }
}

extension CheckAnswerViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        self.view.backgroundColor = .white
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        self.view.addSubviews(checkAnswerView, checkButton)
        
        checkAnswerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(124)
        }
            
        checkButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(36)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
    }
    
    // MARK: - Methods
    
    // MARK: - @objc Methods
}
