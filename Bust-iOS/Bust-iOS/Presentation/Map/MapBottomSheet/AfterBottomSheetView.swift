//
//  AfterBottomSheetView.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/5/24.
//

import UIKit
import SnapKit

final class AfterBottomSheetView: PassThroughView {
    
    enum Mode {
        case tip
        case full
    }
    
    private enum Const {
        static let duration = 0.5
        static let cornerRadius = 20.0
        static let barViewTopSpacing = 6.0
        static let barViewSize = CGSize(width: UIScreen.main.bounds.width * 0.1, height: 4.0)
        static let bottomSheetRatio: (Mode) -> Double = { mode in
            switch mode {
            case .tip:
                return 0.82
            case .full:
                return 0.55
            }
        }
        static let bottomSheetYPosition: (Mode) -> Double = { mode in
            Self.bottomSheetRatio(mode) * UIScreen.main.bounds.height
        }
    }
    
    let bottomSheetView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let barView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray200
        view.isUserInteractionEnabled = false
        view.layer.cornerRadius = 2
        return view
    }()
    
    private let afterTitleLabel = {
        let label = UILabel()
        label.text = "\(UserManager.shared.getUsername)님, 오늘의 장소를 찾아보세요!"
        label.textColor = .mainBlue
        label.asLineHeight(.subtitle1)
        label.font = .fontBust(.subtitle1)
        return label
    }()
    
    private let afterSubTitleLabel = {
        let label = UILabel()
        label.text = "위치를 찾아내고 정답을 확인해보세요!"
        label.textColor = .gray500
        label.asLineHeight(.body21)
        label.font = .fontBust(.body21)
        return label
    }()
    
    let checkAnswerButton = {
        let button = UIButton()
        button.setImage(.btnCheckAnswer, for: .normal)
        button.setImage(.btnCheckAnswer, for: .selected)
        return button
    }()
    
    let useTicketButton = {
        let button = UIButton()
        button.setImage(.btnUseTicket, for: .normal)
        button.setImage(.btnUseTicket, for: .selected)
        return button
    }()
    
    private let reviewBackView = {
        let view = UIView()
        view.backgroundColor = .gray100
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let reviewProfileImageview = UIImageView(image: .graphicProfile)
    
    private let reviewContentLabel = {
        let label = UILabel()
        label.font = .fontBust(.caption11)
        label.textColor = .gray400
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: Properties
    var mode: Mode = .tip {
        didSet {
            switch self.mode {
            case .tip:
                break
            case .full:
                break
            }
            self.updateConstraint(offset: Const.bottomSheetYPosition(self.mode))
        }
    }
    
    var bottomSheetColor: UIColor? {
        didSet { self.bottomSheetView.backgroundColor = self.bottomSheetColor }
    }
    
    var barViewColor: UIColor? {
        didSet { self.barView.backgroundColor = self.barViewColor }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan))
        self.addGestureRecognizer(panGesture)
        
        self.bottomSheetView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.bottomSheetView.layer.cornerRadius = Const.cornerRadius
        self.bottomSheetView.clipsToBounds = true
        
        self.addSubview(self.bottomSheetView)
        self.bottomSheetView.addSubviews(barView, afterTitleLabel, afterSubTitleLabel, checkAnswerButton, useTicketButton, reviewBackView)
        reviewBackView.addSubviews(reviewProfileImageview, reviewContentLabel)
        
        self.bottomSheetView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(Const.bottomSheetYPosition(.tip))
        }
        
        self.barView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(Const.barViewTopSpacing)
            $0.size.equalTo(Const.barViewSize)
        }
        
        afterTitleLabel.snp.makeConstraints {
            $0.top.equalTo(barView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        afterSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(afterTitleLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        checkAnswerButton.snp.makeConstraints {
            $0.top.equalTo(afterSubTitleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(92)
            $0.width.equalTo((SizeLiterals.Screen.screenWidth - 55)/2)
        }
        
        useTicketButton.snp.makeConstraints {
            $0.top.equalTo(afterSubTitleLabel.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(92)
            $0.width.equalTo((SizeLiterals.Screen.screenWidth - 55)/2)
        }
        
        reviewBackView.snp.makeConstraints {
            $0.top.equalTo(checkAnswerButton.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 41)
            $0.height.equalTo(72)
        }
        
        reviewProfileImageview.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(18)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(36)
        }
        
        reviewContentLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(reviewProfileImageview.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(18)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init() has not been implemented")
    }
    
    
    @objc private func didPan(_ recognizer: UIPanGestureRecognizer) {
        let translationY = recognizer.translation(in: self).y
        let minY = self.bottomSheetView.frame.minY
        let offset = translationY + minY
        
        if Const.bottomSheetYPosition(.full)...Const.bottomSheetYPosition(.tip) ~= offset {
            self.updateConstraint(offset: offset)
            recognizer.setTranslation(.zero, in: self)
        }
        UIView.animate(
            withDuration: 0,
            delay: 0,
            options: .curveEaseOut,
            animations: self.layoutIfNeeded,
            completion: nil
        )
        
        guard recognizer.state == .ended else { return }
        UIView.animate(
            withDuration: Const.duration,
            delay: 0,
            options: .allowUserInteraction,
            animations: {
                self.mode = recognizer.velocity(in: self).y >= 0 ? Mode.tip : .full
            },
            completion: nil
        )
    }
    
    private func updateConstraint(offset: Double) {
        self.bottomSheetView.snp.remakeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalToSuperview().inset(offset)
        }
    }
    
    func bindAfterBS(data: Review) {
        reviewContentLabel.text = "\(data.user) - \(data.content)"
        reviewContentLabel.asLineHeight(.caption11)
    }
}
