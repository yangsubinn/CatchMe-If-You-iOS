//
//  PasswordCheckRequest.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/15.
//

import Foundation

struct PasswordCheckRequest: Codable {
    var password: String
    
    init(_ password: String) {
        self.password = password
    }
}
