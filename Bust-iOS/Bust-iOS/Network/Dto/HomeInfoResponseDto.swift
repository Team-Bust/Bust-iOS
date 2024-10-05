//
//  HomeResponseDto.swift
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
    let id: Int
    let title, address: String
    let latitude, longitude: Double
    let detailsLink: String

    enum CodingKeys: String, CodingKey {
        case id, title, address, latitude, longitude
        case detailsLink = "details_link"
    }
}
