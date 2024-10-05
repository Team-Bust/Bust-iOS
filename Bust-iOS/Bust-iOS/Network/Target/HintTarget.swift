//
//  HintTarget.swift
//  Bust-iOS
//
//  Created by KJ on 10/6/24.
//

import Foundation

import Moya

enum HintTarget {
    
    case postMapComplete(dto: HintRequestDto)
}

extension HintTarget: BaseTargetType {
    
    var path: String {
        switch self{
        case .postMapComplete:
            return URLConstant.mapComplete
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .postMapComplete:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self{
        case .postMapComplete(let dto):
            return .requestJSONEncodable(dto)
        }
    }
    
    var headers: [String : String]? {
        return HeaderConstant.noTokenHeader
    }
}
