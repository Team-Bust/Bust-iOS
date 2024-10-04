//
//  OnboardingMenuModel.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/5/24.
//

import UIKit

struct OnboardingMenuModel {
    let image: UIImage
    let title: String
}

extension OnboardingMenuModel {
    
    static func onboardingMenuData() -> [OnboardingMenuModel] {
        return [
            OnboardingMenuModel(image: .imgNature, title: "자연/풍경"),
            OnboardingMenuModel(image: .imgHistory, title: "역사/문화"),
            OnboardingMenuModel(image: .imgFood, title: "카페/맛집"),
            OnboardingMenuModel(image: .imgHotplace, title: "핫플레이스"),
            OnboardingMenuModel(image: .imgHealing, title: "힐링/여유"),
            OnboardingMenuModel(image: .imgArt, title: "예술/전시"),
            OnboardingMenuModel(image: .imgActivity, title: "액티비티"),
            OnboardingMenuModel(image: .imgNight, title: "야경/로맨틱"),
            OnboardingMenuModel(image: .imgShopping, title: "쇼핑")
        ]
    }
}
