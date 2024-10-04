//
//  UIStackView+.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/4/24.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
