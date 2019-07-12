//
//  homeGraphDetailModel.swift
//  GetRestIOS
//
//  Created by 박경선 on 03/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import Foundation

struct HomeGraphDetailModel : Codable {
    let portfolioIdx: String
    let portfolioTitle : String
    let portfolioStartDate : String
    let portfolioExpireDate: String
    
    enum CodingKeys: String, CodingKey {
        case portfolioIdx = "portfolioIdx"
        case portfolioTitle = "portfolioTitle"
        case portfolioStartDate = "portfolioStartDate"
        case portfolioExpireDate = "portfolioExpireDate"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        portfolioIdx = try values.decodeIfPresent(String.self, forKey: .portfolioIdx)!
        portfolioTitle = try values.decodeIfPresent(String.self, forKey: .portfolioTitle)!
        portfolioStartDate = try values.decodeIfPresent(String.self, forKey: .portfolioStartDate)!
        portfolioExpireDate = try values.decodeIfPresent(String.self, forKey: .portfolioExpireDate)!
    }
}
