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
    case postMapCheck(dto: MapCheckRequestDto)
}

extension MapTarget: BaseTargetType {
    
    var path: String {
        switch self{
        case .getMapGame:
            return URLConstant.mapGameURL
        case .postMapCheck:
            return URLConstant.mapCheckURL
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .getMapGame:
            return .get
        case .postMapCheck:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self{
        case .getMapGame:
            return .requestPlain
        case .postMapCheck(let dto):
            return .requestJSONEncodable(dto)
        }
    }
    
    var headers: [String : String]? {
        return HeaderConstant.noTokenHeader
    }
}
