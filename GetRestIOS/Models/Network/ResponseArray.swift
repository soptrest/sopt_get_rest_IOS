//
//  ResponseArray.swift
//  GetRestIOS
//
//  Created by 박경선 on 11/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

struct ResponseArray<T: Codable>: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [T]?
}
