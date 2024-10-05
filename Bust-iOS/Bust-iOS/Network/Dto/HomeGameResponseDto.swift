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
    let 도로명주소: String
    let 식당ID: Int
    let 식당경도, 식당대표전화번호, 식당명, 식당위도: String
    let 영업신고증업태명, 영업인허가명, 음식점소개내용, 지번주소: String
    let 위도, 경도: String

    enum CodingKeys: String, CodingKey {
        case 도로명주소
        case 식당ID = "식당(ID)"
        case 식당경도, 식당대표전화번호, 식당명, 식당위도, 영업신고증업태명, 영업인허가명, 음식점소개내용, 지번주소, 위도, 경도
    }
}
