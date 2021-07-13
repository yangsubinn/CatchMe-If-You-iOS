//
//  EmailCheckRequest.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/13.
//

import Foundation

struct EmailCheckRequest: Codable {
    var email: String
    
    init(_ email: String) {
        self.email = email
    }
}
