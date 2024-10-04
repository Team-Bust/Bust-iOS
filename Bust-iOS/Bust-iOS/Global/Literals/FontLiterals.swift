//
//  FontLiterals.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/4/24.
//

import UIKit

enum FontName: String {
    case PretendardSemiBold = "Pretendard-SemiBold"
    case PretendardBold = "Pretendard-Bold"
    case PretendardRegular = "Pretendard-Regular"
}

enum FontLevel {
    case heading1
    case heading2
    case heading3
    
    case title1
    case subtitle1
    case body1
    case body11
    case body2
    case body21
    case caption1
    case caption11
}

extension FontLevel {
    
    var fontWeight: String {
        switch self {
        case .heading1, .heading2, .heading3, .title1, .body1, .body2, .caption1:
            return FontName.PretendardBold.rawValue
        case .body11, .body21, .caption11:
            return FontName.PretendardRegular.rawValue
        case .subtitle1:
            return FontName.PretendardSemiBold.rawValue
        }
    }
    
    var fontSize: CGFloat {
        switch self {
        case .heading1:
            return 48
        case .heading2:
            return 28
        case .heading3:
            return 24
        case .title1:
            return 20
        case .subtitle1:
            return 18
        case .body1, .body11:
            return 16
        case .body2, .body21:
            return 14
        case .caption1, .caption11:
            return 12
        }
    }
    
    var lineHeight: CGFloat {
        switch self {
        case .heading1:
            return 60
        case .heading2:
            return 34
        case .heading3:
            return 30
        case .title1:
            return 26
        case .subtitle1:
            return 24
        case .body1, .body11:
            return 22
        case .body2, .body21:
            return 20
        case .caption1, .caption11:
            return 18
        }
    }
}

extension UIFont {
    
    static func fontBust(_ fontLevel: FontLevel) -> UIFont {
        let font = UIFont(name: fontLevel.fontWeight, size: fontLevel.fontSize)!
        return font
    }
}
