//
//  MypageDetailResponseDto.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/6/24.
//

struct MypageDetailResponseDto: Codable {
    let userName: String
    let history: History

    enum CodingKeys: String, CodingKey {
        case userName = "user_name"
        case history
    }
}

// MARK: - History
struct History: Codable {
    let image: String
    let placeName, address, description, hint: String

    enum CodingKeys: String, CodingKey {
        case image
        case placeName = "place_name"
        case address, description, hint
    }
}
