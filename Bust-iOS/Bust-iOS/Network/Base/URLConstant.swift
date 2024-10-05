//
//  URLConstant.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/4/24.
//

import Foundation

enum URLConstant {
    
    // MARK: - Base URL
    
    static let baseURL = Config.baseURL
    
    // home
    
    static let homeInfoURL = "/home/info"
    static let homeGameURL = "/home/game"
    
    // map
    
    static let mapGameURL = "/map/game"
    static let mapCheckURL = "/map/check"
    static let mapTicketURL = "/map/ticket"
    
    // hint
    
    static let mapComplete = "/map/complete"
    
    // mypage
    
    static let mypageInfo = "/mypage/info"
    static let mypageDetail = "/mypage/detail/{historyId}"
}
