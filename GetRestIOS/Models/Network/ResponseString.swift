//
//  ResponseString.swift
//  GetRestIOS
//
//  Created by 박경선 on 12/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

struct ResponseString: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: String?
}
