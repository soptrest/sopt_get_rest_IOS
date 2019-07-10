//
//  MyResumeDetailModel.swift
//  GetRestIOS
//
//  Created by 박경선 on 10/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import Foundation


struct MyResumeDetailModel : Codable {
    var jobTitle : String?
    var jobType : String?
    var content: String?
    
    
    init(_ jobTitle: String, _ jobType: String, _ content: String){
        self.jobTitle = jobTitle
        self.jobType = jobType
        self.content = content
    }
    
}
