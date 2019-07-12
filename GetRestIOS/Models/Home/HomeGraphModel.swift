//
//  HomeGraphModel.swift
//  GetRestIOS
//
//  Created by 박경선 on 11/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import Foundation

struct HomeGraphModel : Codable {
    let date : String
    let count : Int
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case count = "count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        date = try values.decodeIfPresent(String.self, forKey: .date)!
        count = try values.decodeIfPresent(Int.self, forKey: .count)!
    }
}
