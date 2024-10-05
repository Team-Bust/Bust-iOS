//
//  MapTarget.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/5/24.
//

import Foundation

import Moya

enum MapTarget {
    
    case getMapGame
}

extension MapTarget: BaseTargetType {
    
    var path: String {
        switch self{
        case .getMapGame:
            return URLConstant.mapGameURL
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return HeaderConstant.noTokenHeader
    }
}
