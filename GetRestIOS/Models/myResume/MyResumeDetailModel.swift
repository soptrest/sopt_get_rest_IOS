//
//  MyResumeDetailModel.swift
//  GetRestIOS
//
//  Created by 박경선 on 10/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import Foundation


struct MyResumeDetailModel : Codable {
    var questionIdx: Int = 0
    var questionTitle : String
    var recruitJobType : String
    var resumeContent: String

    init(_ Idx: Int, _ jobTitle: String, _ jobType: String, _ content: String){
        self.questionIdx = Idx
        self.questionTitle = jobTitle
        self.recruitJobType = jobType
        self.resumeContent = content
    }
    
}
