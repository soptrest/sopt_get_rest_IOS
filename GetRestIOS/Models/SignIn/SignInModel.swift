//
//  SignInModel.swift
//  GetRestIOS
//
//  Created by 박경선 on 12/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import Foundation

struct SignInModel: Codable {
    var userToken: String
    var userIdx: Int
    var userName: String
    var timestamp: Float
    
    enum CodingKeys: String, CodingKey {
        case userToken = "userToken"
        case userIdx = "userIdx"
        case userName = "userName"
        case timestamp = "timestamp"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userToken = try values.decodeIfPresent(String.self, forKey: .userToken)!
        userIdx = try values.decodeIfPresent(Int.self, forKey: .userIdx)!
        userName = try values.decodeIfPresent(String.self, forKey: .userName)!
        timestamp = try values.decodeIfPresent(Float.self, forKey: .timestamp)!
    }
}
