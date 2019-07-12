//
//  RecruitListModel.swift
//  GetRestIOS
//
//  Created by 최리안 on 08/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import Foundation
import UIKit

struct RecruitListModel{
    var rcImg: UIImage?
    var rcTitle: String
    var rcField: String
    var rcDate: String
    var starChecked: Bool
    
    init(img: String, title: String, field: String, date: String){
        self.rcImg = UIImage(named: img)
        self.rcTitle = title
        self.rcField = field
        self.rcDate = date
        self.starChecked = false
    }
}
//
//struct RecruitListlModel : Codable {
//    var rcImg: UIImage?
//    var rcTitle: String
//    var rcField: String
//    var rcDate: String
//
//    enum CodingKeys: String, CodingKey {
//        case rcImg
//        case rcTitle
//        case rcField
//        case rcDate
//
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        rcTitle = try container.decode(String.self, forKey: .rcTitle)
//        rcField = try container.decode(String.self, forKey: .rcField)
//        rcDate = try container.decode(String.self, forKey: .rcDate)
//
//        if let text = try container.decodeIfPresent(String.self, forKey: .rcImg) {
//            if let data = Data(base64Encoded: text) {
//                rcImg = UIImage(data: data)
//            }
//        }
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//
//        if let rcImg = rcImg, let data = rcImg.pngData() {
//            try container.encode(data, forKey: .rcImg)
//        }
//        try container.encode(rcTitle, forKey: .rcTitle)
//        try container.encode(rcField, forKey: .rcField)
//        try container.encode(rcDate, forKey: .rcDate)
//    }
//}
//

