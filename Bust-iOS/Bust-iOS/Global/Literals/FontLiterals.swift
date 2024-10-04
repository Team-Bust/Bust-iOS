//
//  FontLiterals.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/4/24.
//

import UIKit

enum FontName: String {
    case PretendardMedium = "Pretendard-Medium"
    case PretendardSemiBold = "Pretendard-SemiBold"
    case PretendardBold = "Pretendard-Bold"
    case PretendardExtraBold = "Pretendard-ExtraBold"
    case PretendardRegular = "Pretendard-Regular"
}

enum FontLevel {
    case head1
    case head2
    case head3
    case head4
    
    case body1Bold
    case body1Reg
    case body2Bold
    case body2Reg
    case body3Bold
    case body3Medi
    case body3Reg
    
    case detail1Bold
    case detail1Reg
    case detail2Bold
    case detail2Reg
    case detail2Semi
    case detail3Semi
    case detail3Reg
}

extension FontLevel {
    
    var fontWeight: String {
        switch self {
        case .head1:
            return FontName.PretendardExtraBold.rawValue
        case .head2, .head3, .head4,
                .body1Bold, .body2Bold, .body3Bold,
                .detail1Bold, .detail2Bold:
            return FontName.PretendardBold.rawValue
        case .body1Reg, .body2Reg, .body3Reg,
                .detail1Reg, .detail2Reg, .detail3Reg:
            return FontName.PretendardRegular.rawValue
        case .body3Medi:
            return FontName.PretendardMedium.rawValue
        case .detail3Semi, .detail2Semi:
            return FontName.PretendardSemiBold.rawValue
        }
    }
    
    var fontSize: CGFloat {
        switch self {
        case .head1:
            return 24
        case .head2:
            return 22
        case .head3:
            return 20
        case .head4:
            return 18
        case .body1Bold, .body1Reg:
            return 16
        case .body2Bold, .body2Reg:
            return 15
        case .body3Bold, .body3Medi, .body3Reg:
            return 14
        case .detail1Bold, .detail1Reg:
            return 13
        case .detail2Bold, .detail2Reg, .detail2Semi:
            return 12
        case .detail3Semi, .detail3Reg:
            return 11
        }
    }
    
    var lineHeight: CGFloat {
        switch self {
        case .head1, .head2, .head3, .head4:
            return self.fontSize * 1.5
        case .body3Reg:
            return self.fontSize * 1.8
        default:
            return self.fontSize * 1.4
        }
    }
}

extension UIFont {
    static func hisFont(_ fontLevel: FontLevel) -> UIFont {
        let font = UIFont(name: fontLevel.fontWeight, size: fontLevel.fontSize)!
        return font
    }
}
