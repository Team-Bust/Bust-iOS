//
//  BaseTargetType.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/4/24.
//

import Foundation

import Moya

protocol BaseTargetType: TargetType {}

extension BaseTargetType {
    
    var baseURL: URL {
        return URL(string: URLConstant.baseURL)!
    }
}
