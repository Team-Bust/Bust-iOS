//
//  SettingMenu.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/5/24.
//

struct SettingMenu {
    let title: String
}

extension SettingMenu {
    static func serviceMenu() -> [SettingMenu] {
        return [
            SettingMenu(title: "이용약관"),
            SettingMenu(title: "개인정보처리방침")
        ]
    }
    
    static func accountMenu() -> [SettingMenu] {
        return [
            SettingMenu(title: "로그아웃"),
            SettingMenu(title: "탙퇴하기")
        ]
    }
}
