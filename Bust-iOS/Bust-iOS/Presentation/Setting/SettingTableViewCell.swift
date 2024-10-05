//
//  SettingTableViewCell.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/5/24.
//

import UIKit

import SnapKit

final class SettingTableViewCell: UITableViewCell, UITableViewRegisterable {
    
    // MARK: - Properties
    
    static let isFromNib: Bool = false
    
    // MARK: - UI Components
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .gray500
        label.font = .fontBust(.body11)
        return label
    }()
    
    private let settingGoButton: UIButton = {
        let button = UIButton()
        button.setImage(.icArrowNextTouch, for: .normal)
        return button
    }()
    
    // MARK: - Life Cycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setUI()
        setHierarchy()
        setLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension SettingTableViewCell {

    func setUI() {
        backgroundColor = .white
        self.selectionStyle = .none
    }
    
    func setHierarchy() {
        addSubviews(titleLabel, settingGoButton)
    }
    
    func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        settingGoButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(4)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(48)
        }
    }
}

extension SettingTableViewCell {

    func configureSettingCell(menu: SettingMenu) {
        titleLabel.text = menu.title
    }
}
