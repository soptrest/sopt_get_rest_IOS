//
//  homeGraphDetailModel.swift
//  GetRestIOS
//
//  Created by 박경선 on 03/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import Foundation

struct HomeGraphDetailModel : Codable {
    let portfolioTitle : String?
    let portfolioDuration : String?
//    let portfolioHashTags : [String]?
    
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
    init(_ title: String,_ duration: String){
        self.portfolioTitle = title
        self.portfolioDuration = duration
    }
    
}
