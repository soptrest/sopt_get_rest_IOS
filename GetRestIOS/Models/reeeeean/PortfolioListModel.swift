//
//  PortfolioListModel.swift
//  GetRestIOS
//
//  Created by 박경선 on 13/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import Foundation


struct PortfolioListModel : Codable {
    var portfolioIdx: Int
    var portfolioTitle: String
    var portfolioStartDate: String
    var portfolioExpireDate: String
    var portfolioCategory: String
    var tag : [String]
    var portfolioImage : String?
    
    enum CodingKeys: String, CodingKey {
        case portfolioIdx = "portfolioIdx"
        case portfolioTitle = "portfolioTitle"
        case portfolioStartDate = "portfolioStartDate"
        case portfolioExpireDate = "portfolioExpireDate"
        case portfolioCategory = "portfolioCategory"
        case tag = "tag"
        case portfolioImage = "portfolioImage"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        portfolioIdx = try values.decodeIfPresent(Int.self, forKey: .portfolioIdx)!
        portfolioTitle = try values.decodeIfPresent(String.self, forKey: .portfolioTitle)!
        portfolioStartDate = try values.decodeIfPresent(String.self, forKey: .portfolioStartDate)!
        portfolioExpireDate = try values.decodeIfPresent(String.self, forKey: .portfolioExpireDate)!
        portfolioCategory = try values.decodeIfPresent(String.self, forKey: .portfolioCategory)!
        tag = [""]
        portfolioImage = ""
//        tag = try values.decodeIfPresent([String].self, forKey: .tag)!
//        portfolioImage = try values.decodeIfPresent(String.self, forKey: .portfolioImage)!
    }

}

