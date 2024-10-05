//
//  HomeTarget.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/5/24.
//

import Foundation

import Moya

enum HomeTarget {
    
    case getHomeInfo
    case getUserGame
}

extension HomeTarget: BaseTargetType {
    
    var path: String {
        switch self{
        case .getHomeInfo:
            return URLConstant.homeInfoURL
        case .getUserGame:
            return URLConstant.homeGameURL
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
