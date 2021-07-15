//
//  AddActionRequest.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/15.
//

import Foundation

struct AddActionRequest: Codable {
    var activityImage: String // 여기 좀. 아지 ㄱ문제임ㅅ..
    var activityContent: String
    var activityYear: String
    var activityMonth: String
    var activityDay: String
    var characterIndex: Int
    
    init(_ image: String, content: String, year: String, month: String, day: String, index: Int) {
        self.activityImage = image
        self.activityContent = content
        self.activityYear = year
        self.activityMonth = month
        self.activityDay = day
        self.characterIndex = index
    }
}
