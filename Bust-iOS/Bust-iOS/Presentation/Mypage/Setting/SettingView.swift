//
//  SettingView.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/5/24.
//

import UIKit

import SnapKit

final class SettingView: UIView {
    
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
    
    private let settingTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "설정"
        label.textAlignment = .left
        label.textColor = .black
        label.font = .fontBust(.heading3)
        return label
    }()
    
    private let settingServiceLabel: UILabel = {
        let label = UILabel()
        label.text = "서비스 약관"
        label.textAlignment = .left
        label.textColor = .gray500
        label.font = .fontBust(.body2)
        return label
    }()
    
    let settingServiceTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.rowHeight = 52
        tableView.sectionFooterHeight = 0
        tableView.sectionHeaderTopPadding = 0
        return tableView
    }()
    
    private let divideView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray100
        return view
    }()
    
    private let settingAccountHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "계정설정"
        label.textAlignment = .left
        label.textColor = .gray500
        label.font = .fontBust(.body2)
        return label
    }()
    
    let settingAccountTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.isUserInteractionEnabled = true
        tableView.separatorStyle = .none
        tableView.rowHeight = 52
        tableView.sectionFooterHeight = 0
        tableView.sectionHeaderTopPadding = 0
        return tableView
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setRegisterCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension SettingView {

    func setUI() {
        backgroundColor = .white
    }
    
    func setHierarchy() {
        navigationBar.addSubview(backButton)
        addSubviews(navigationBar, settingTitleLabel, settingServiceLabel, settingServiceTableView,
                    divideView, settingAccountHeaderLabel, settingAccountTableView)
    }
    
    func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        backButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        settingTitleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(9)
            $0.leading.equalToSuperview().inset(16)
        }
        
        settingServiceLabel.snp.makeConstraints {
            $0.top.equalTo(settingTitleLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(20)
        }
        
        settingServiceTableView.snp.makeConstraints {
            $0.top.equalTo(settingServiceLabel.snp.bottom).offset(2)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(104)
        }
        
        divideView.snp.makeConstraints {
            $0.top.equalTo(settingServiceTableView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(10)
        }
        
        settingAccountHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(divideView.snp.bottom).offset(14)
            $0.leading.equalToSuperview().inset(20)
        }
        
        settingAccountTableView.snp.makeConstraints {
            $0.top.equalTo(settingAccountHeaderLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(104)
        }
    }
    
    func setRegisterCell() {
        SettingTableViewCell.register(target: settingServiceTableView)
        SettingTableViewCell.register(target: settingAccountTableView)
    }
}
