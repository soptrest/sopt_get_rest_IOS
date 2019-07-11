//
//  HomeGraphModel.swift
//  GetRestIOS
//
//  Created by 박경선 on 11/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import Foundation

struct HomeGraphModel : Codable {
    let date : String?
    let count : Int?
    
    init(_ date: String, _ count: Int){
        self.date = date
        self.count = count
    }
}
