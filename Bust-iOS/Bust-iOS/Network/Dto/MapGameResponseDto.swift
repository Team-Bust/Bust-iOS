//
//  MapGameResponseDto.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/5/24.
//

struct MapGameResponseDto: Codable {
    let place: MapGamePlace
    let gameStarted: Bool
    let tickets: Int

    enum CodingKeys: String, CodingKey {
        case place
        case gameStarted = "game_started"
        case tickets
    }
}

// MARK: - Place
struct MapGamePlace: Codable {
    let 위도, 경도: String
}
