//
//  SignupRequest.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/13.
//

import Foundation

struct SignupRequest: Codable {
    var email: String
    var nickname: String
    var password: String
    
    init(_ email: String, _ nickname: String, _ password: String) {
        self.email = email
        self.nickname = nickname
        self.password = password
    }
}
