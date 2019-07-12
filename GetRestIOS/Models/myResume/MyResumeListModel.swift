//
//  MyResumeListModel.swift
//  GetRestIOS
//
//  Created by 박경선 on 10/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

struct MyResumeListModel : Codable {
    var resumeIdx : Int
    var recruitIdx : Int
    var companyIdx : Int
    var recruitJobType: String
    var recruitStartDate: String
    var recruitExpireDate : String
    var leftDate : Int
    var companyName : String
    var expireCheck : Bool
    
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
    init(_ resumeIdx: Int, _ recruitIdx: Int, _ companyIdx: Int,_ recruitJobType: String,_ startDate: String,_ expireDate: String, _ leftDate: Int, _ companyName: String, expireCheck: Bool){
        self.resumeIdx = resumeIdx
        self.recruitIdx = recruitIdx
        self.companyIdx = companyIdx
        self.recruitJobType = recruitJobType
        self.recruitStartDate = startDate
        self.recruitExpireDate = expireDate
        self.leftDate = leftDate
        self.companyName = companyName
        self.expireCheck = expireCheck
    }
    
}
