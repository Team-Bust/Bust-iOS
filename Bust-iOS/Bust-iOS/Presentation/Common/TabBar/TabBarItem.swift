//
//  TabBarItem.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/5/24.
//

import UIKit

enum TabBarItemType: Int, CaseIterable {
    case home
    case map
    case myPage
}

extension TabBarItemType {
    
    var unSelectedIcon: UIImage {
        switch self {
        case .home:
            return .icHomeUnselected
        case .map:
            return .icMapUnselected
        case .myPage:
            return .icMypageUnselected
        }
    }
    
    var selectedIcon: UIImage {
        switch self {
        case .home:
            return .icHomeSelected
        case .map:
            return .icMapSelected
        case .myPage:
            return .icMypageSelected
        }
    }
    
    func setTabBarItem() -> UITabBarItem {
        return UITabBarItem(title: "", image: unSelectedIcon, selectedImage: selectedIcon)
    }
}
