//
//  DeleteRequest.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/15.
//

import Foundation

struct DeleteRequest: Codable {
    var characterIndex: Int
    var activityIndex: Int
    
    init(_ catchuIndex: Int, index: Int) {
        self.characterIndex = catchuIndex
        self.activityIndex = index
    }
}
