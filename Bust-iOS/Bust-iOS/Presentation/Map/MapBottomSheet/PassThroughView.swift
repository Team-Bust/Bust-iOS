//
//  PassThroughView.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/5/24.
//

import UIKit

class PassThroughView: UIView {
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        return hitView == self ? nil : hitView
    }
}
