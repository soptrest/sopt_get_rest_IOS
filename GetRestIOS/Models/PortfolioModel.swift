//
//  PortfolioModel.swift
//  GetRestIOS
//
//  Created by 최리안 on 07/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import Foundation
import UIKit

struct PortfoliolModel{
    var pfImg: UIImage?
    var pfTitle: String
    var pfDate: String
    
    init(img: String, title: String, date: String){
        self.pfImg = UIImage(named: img)
        self.pfTitle = title
        self.pfDate = date
    }
}
//
//struct PortfoliolModel : Codable {
//    var pfImg: UIImage?
//    var pfTitle: String
//    var pfDate: String
//
//    enum CodingKeys: String, CodingKey {
//        case pfImg
//        case pfTitle
//        case pfDate
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        pfTitle = try container.decode(String.self, forKey: .pfTitle)
//        pfDate = try container.decode(String.self, forKey: .pfDate)
//
//        if let text = try container.decodeIfPresent(String.self, forKey: .pfImg) {
//            if let data = Data(base64Encoded: text) {
//                pfImg = UIImage(data: data)
//            }
//        }
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//
//        if let pfImg = pfImg, let data = pfImg.pngData() {
//            try container.encode(data, forKey: .pfImg)
//        }
//        try container.encode(pfTitle, forKey: .pfTitle)
//        try container.encode(pfDate, forKey: .pfDate)
//    }
//}
//
