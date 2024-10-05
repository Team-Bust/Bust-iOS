//
//  MypageResponseDto.swift
//  Bust-iOS
//
//  Created by KJ on 10/6/24.
//

// MARK: - DataClass
struct MypageResponseDto: Codable {
    let userName: String
    let history: [History]

    enum CodingKeys: String, CodingKey {
        case userName = "user_name"
        case history
    }
}

// MARK: - History
struct History: Codable {
    let image, placeName, address, timestamp, hint: String
    let success: Bool

    enum CodingKeys: String, CodingKey {
        case placeName = "place_name"
        case image, address, timestamp, success, hint
    }
}
