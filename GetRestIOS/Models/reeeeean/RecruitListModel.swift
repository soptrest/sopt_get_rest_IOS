//
//  RecruitListModel.swift
//  GetRestIOS
//
//  Created by 박경선 on 13/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import Foundation
struct RecruitListModel : Codable {
    var recruitIdx: Int
    var companyName: String
    var companyImage: String
    var recruitJobCategory: String
    var recruitExpireDate: String
    
    enum CodingKeys: String, CodingKey {
        case recruitIdx = "recruitIdx"
        case recruitJobCategory = "recruitJobCategory"
        case recruitExpireDate = "recruitExpireDate"
        case companyName = "companyName"
        case companyImage = "companyImage"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        recruitIdx = try values.decodeIfPresent(Int.self, forKey: .recruitIdx)!
        companyName = try values.decodeIfPresent(String.self, forKey: .companyName)!
        companyImage = try values.decodeIfPresent(String.self, forKey: .companyImage)!
        recruitJobCategory = try values.decodeIfPresent(String.self, forKey: .recruitJobCategory)!
        recruitExpireDate = try values.decodeIfPresent(String.self, forKey: .recruitExpireDate)!
    }
    
}
