//
//  OnboardingCollectionViewCell.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/5/24.
//

import UIKit

import SnapKit

final class OnboardingCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties
    
    static var isFromNib = false
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .lightBlue : .gray100
            titleLabel.textColor = isSelected ? .mainBlue : .gray400
            layer.borderWidth = isSelected ? 1 : 0
            layer.borderColor = isSelected ? UIColor.mainBlue.cgColor : UIColor.clear.cgColor
        }
    }
    
    // MARK: - UI Components
    
    private let stackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 8
        stackview.alignment = .center
        return stackview
    }()
    
    private let imageView = UIImageView()
    
    private let titleLabel = {
        let label = UILabel()
        label.textColor = .gray400
        label.font = .fontBust(.body2)
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
    
    override func prepareForReuse() {
        isSelected = false
    }
}

private extension OnboardingCollectionViewCell {
     
    func setUI() {
        self.backgroundColor = .gray100
        self.layer.cornerRadius = 8
    }
    
    func setHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubviews(imageView,
                                      titleLabel)
    }
    
    func setLayout() {
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(64)
            $0.height.equalTo(83)
        }
        
        imageView.snp.makeConstraints {
            $0.centerX.top.equalToSuperview()
            $0.size.equalTo(55)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.bottom.equalToSuperview()
        }
    }
}

extension OnboardingCollectionViewCell {
    
    func bindOnboarding(model: OnboardingMenuModel) {
        imageView.image = model.image
        titleLabel.text = model.title
        titleLabel.asLineHeight(.body2)
    }
}
