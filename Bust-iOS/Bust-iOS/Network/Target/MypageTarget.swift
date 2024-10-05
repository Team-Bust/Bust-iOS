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
    case getMypageDetail(id: Int)
}

extension MypageTarget: BaseTargetType {
    
    var path: String {
        switch self{
        case .getMypage:
            return URLConstant.mypageInfo
        case .getMypageDetail(let id):
            let path = URLConstant.mypageDetail
                .replacingOccurrences(of: "{historyId}", with: String(id))
            return path
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
