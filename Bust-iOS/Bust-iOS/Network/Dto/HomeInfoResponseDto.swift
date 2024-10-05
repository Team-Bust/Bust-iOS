//
//  HomeInfoResponseDto.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/5/24.
//

struct HomeInfoResponseDto: Codable {
    let username: String
    let tickets: Int
    let grade: String
    let gameCount: Int
    let recommendedPlaces: [RecommendedPlace]

    enum CodingKeys: String, CodingKey {
        case username, tickets, grade
        case gameCount = "game_count"
        case recommendedPlaces = "recommended_places"
    }
}

// MARK: - RecommendedPlace
struct RecommendedPlace: Codable {
    let image: String
    let title, address: String
}
