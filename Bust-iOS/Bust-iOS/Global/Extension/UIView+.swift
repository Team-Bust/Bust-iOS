//
//  UIView+.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/4/24.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
