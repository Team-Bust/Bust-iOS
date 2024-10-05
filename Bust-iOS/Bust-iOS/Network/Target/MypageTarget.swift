//
//  MypageTarget.swift
//  Bust-iOS
//
//  Created by KJ on 10/6/24.
//

import Foundation

import Moya

enum MypageTarget {
    
    case getMypage
}

extension MypageTarget: BaseTargetType {
    
    var path: String {
        switch self{
        case .getMypage:
            return URLConstant.mypageInfo
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .getMypage:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self{
        case .getMypage:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return HeaderConstant.noTokenHeader
    }
}
