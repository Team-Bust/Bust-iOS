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
    case getMapCheck
    case getMapTicket
}

extension MapTarget: BaseTargetType {
    
    var path: String {
        switch self{
        case .getMapGame:
            return URLConstant.mapGameURL
        case .getMapCheck:
            return URLConstant.mapCheckURL
        case .getMapTicket:
            return URLConstant.mapTicketURL
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
