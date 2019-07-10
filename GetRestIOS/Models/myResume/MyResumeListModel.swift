//
//  MyResumeListModel.swift
//  GetRestIOS
//
//  Created by 박경선 on 10/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

struct MyResumeListModel : Codable {
    var date : Int?
    var jobTitle : String?
    var jobType : String?
    var expireCheck: Bool?
    
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
    init(_ date: Int, _ title: String, _ type: String){
        self.date = date
        self.jobTitle = title
        self.jobType = type
    }
    
}
