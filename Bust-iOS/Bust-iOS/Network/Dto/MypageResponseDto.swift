//
//  MypageResponseDto.swift
//  Bust-iOS
//
//  Created by KJ on 10/6/24.
//

struct MypageResponseDto: Codable {
    let userName: String
    let history: [MypageHistory]

    enum CodingKeys: String, CodingKey {
        case userName = "user_name"
        case history
    }
}

// MARK: - History
struct MypageHistory: Codable {
    let id: Int
    let image: String
    let placeName, address, timestamp: String
    let success: Bool
    let hint: String

    enum CodingKeys: String, CodingKey {
        case id, image
        case placeName = "place_name"
        case address, timestamp, success, hint
    }
}
