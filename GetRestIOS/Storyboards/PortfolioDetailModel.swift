//
//  PortfolioDetailModel.swift
//  GetRestIOS
//
//  Created by 박경선 on 04/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import Foundation

struct PortfolioDetailModel : Codable {
    let portfolioCategory : String?
    let portfolioTitle : String?
    let portfolioDuration : String?
    let portfolioHashTags : [String]?
    let portfolioContent: String?
    
    //    enum CodingKeys: String, CodingKey {
    //        case userIdx = "userIdx"
    //        case storeIdx = "storeIdx"
    //        case isFavorite = "isFavorite"
    //    }
    //
    //    init(from decoder: Decoder) throws {}
    //        let values = try decoder.container(keyedBy: CodingKeys.self)
    //        portfolioTitle = try values.decodeIfPresent(String.self, forKey: .portfolioTitle)
    //        portfolioDuration = try values.decodeIfPresent(String.self, forKey: .portfolioDuration)
    //        portfolioHashTags = try values.decodeIfPresent(String.self, forKey: .portfolioHashTags)
    //    }
    init(_ category: String, _ title: String, _ duration: String, _ hashTag: [String] = [], _ content: String){
        self.portfolioCategory = category
        self.portfolioTitle = title
        self.portfolioDuration = duration
        self.portfolioHashTags = hashTag
        self.portfolioContent = content
    }
    
}
