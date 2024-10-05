//
//  CheckButton.swift
//  Bust-iOS
//
//  Created by KJ on 10/5/24.
//

import UIKit

enum CheckButtonState {
    case allow
    case notAllow
}

final class CheckButton: UIButton {
    
    // MARK: - Initializer
    
    init() {
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components Property
    
    func setUI() {
        layer.cornerRadius = 8
        titleLabel?.font = .fontBust(.body1)
        setTitleColor(.white, for: .normal)
        setState(.notAllow)
    }
    
    // MARK: - Methods
    
    public func setState(_ state: CheckButtonState) {
        if state == .allow {
            backgroundColor = .mainBlue
            isUserInteractionEnabled = true
        } else {
            backgroundColor = .gray200
            isUserInteractionEnabled = false
        }
    }
}

