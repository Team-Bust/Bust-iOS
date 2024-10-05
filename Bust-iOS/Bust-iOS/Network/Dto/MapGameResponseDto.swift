//
//  MapGameResponseDto.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/5/24.
//

struct MapGameResponseDto: Codable {
    let place: MapPlace
    let gameStarted: Bool
    let tickets: Int

    enum CodingKeys: String, CodingKey {
        case place
        case gameStarted = "game_started"
        case tickets
    }
}

// MARK: - Place
struct MapPlace: Codable {
    let latitude, longitude, review: String
}
