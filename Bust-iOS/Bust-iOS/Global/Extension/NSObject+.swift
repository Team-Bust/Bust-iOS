//
//  NSObject+.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/4/24.
//

import Foundation

extension NSObject {
    
    static var className: String {
        return String(describing: self)
    }
}
