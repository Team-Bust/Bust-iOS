//
//  BeforBottomSheetView.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/5/24.
//

import UIKit
import SnapKit

final class BeforBottomSheetView: PassThroughView {
    
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
    
    private let beforeTitleLabel = {
        let label = UILabel()
        label.text = "\(UserManager.shared.getUsername)님, 아직 미션 전입니다"
        label.textColor = .black
        label.asLineHeight(.subtitle1)
        label.font = .fontBust(.subtitle1)
        return label
    }()
    
    private let beforeSubTitleLabel = {
        let label = UILabel()
        label.text = "오늘의 미션을 시작하고 장소를 맞춰보세요!"
        label.textColor = .gray500
        label.asLineHeight(.body21)
        label.font = .fontBust(.body21)
        return label
    }()
    
    private let beforeImageView = UIImageView(image: .graphicNoMission)
    
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
        self.bottomSheetView.addSubviews(barView, beforeTitleLabel, beforeSubTitleLabel, beforeImageView)
        
        self.bottomSheetView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(Const.bottomSheetYPosition(.tip))
        }
        
        self.barView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(Const.barViewTopSpacing)
            $0.size.equalTo(Const.barViewSize)
        }
        
        beforeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(barView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        beforeSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(beforeTitleLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        beforeImageView.snp.makeConstraints {
            $0.top.equalTo(beforeSubTitleLabel.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(120)
            $0.height.equalTo(134)
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
}
