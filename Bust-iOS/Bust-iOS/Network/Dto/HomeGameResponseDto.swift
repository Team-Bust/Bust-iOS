//
//  HomeGameResponseDto.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/5/24.
//

struct HomeGameResponseDto: Codable {
    let place: Place
    let gameStarted: Bool

    enum CodingKeys: String, CodingKey {
        case place
        case gameStarted = "game_started"
    }
}

// MARK: - Place
struct Place: Codable {
    let 위도, 경도, review: String
}
