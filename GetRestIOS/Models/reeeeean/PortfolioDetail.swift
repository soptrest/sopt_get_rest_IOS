//
//  PortfolioDetail.swift
//  GetRestIOS
//
//  Created by 최리안 on 13/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import Foundation


struct PortfolioDetail : Codable {
//    var portfolioIdx: Int
    var portfolioTitle: String
    var portfolioStartDate: String
    var portfolioExpireDate: String
    var portfolioCategory: String
    var portfolioBody :String
    var portfolioTag :[String]
    var portfolioImg :String?
    
    enum CodingKeys: String, CodingKey {
//        case portfolioIdx = "portfolioIdx"
        case portfolioTitle = "portfolioTitle"
        case portfolioStartDate = "portfolioStartDate"
        case portfolioExpireDate = "portfolioExpireDate"
        case portfolioBody = "portfolioBody"
        case portfolioCategory = "portfolioCategory"
        case portfolioTag = "portfolioTag"
        case portfolioImg = "portfolioImg"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
//        portfolioIdx = try values.decodeIfPresent(Int.self, forKey: .portfolioIdx)!
        portfolioTitle = try values.decodeIfPresent(String.self, forKey: .portfolioTitle)!
        portfolioStartDate = try values.decodeIfPresent(String.self, forKey: .portfolioStartDate)!
        portfolioExpireDate = try values.decodeIfPresent(String.self, forKey: .portfolioExpireDate)!
        portfolioCategory = try values.decodeIfPresent(String.self, forKey: .portfolioCategory)!
        portfolioBody = try values.decodeIfPresent(String.self, forKey: .portfolioBody)!
        //    tag = try values.decodeIfPresent([String].self, forKey: .tag)!
        portfolioTag = ["경선", "리안", "ios"]
        portfolioImg =  try values.decodeIfPresent(String.self, forKey: .portfolioImg)!
    }
    
}
