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
    
    init(_ idx: String, _ title: String, _ startDate: String, _ endDate: String){
        self.portfolioIdx = idx
        self.portfolioTitle = title
        self.portfolioStartDate = startDate
        self.portfolioExpireDate = endDate
    }
}
