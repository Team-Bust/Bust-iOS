//
//  GeneralResponse.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/4/24.
//

import Foundation

struct GeneralResponse<T: Codable>: Codable {
    
    var code: Int
    var message: String
    var data: T?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = (try? values.decode(Int.self, forKey: .code)) ?? 500
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(T.self, forKey: .data)) ?? nil
    }
}
