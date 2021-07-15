//
//  NicknameRequest.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/15.
//

import Foundation

struct NicknameRequest: Codable {
    var nickname: String
    
    init(_ nickname: String) {
        self.nickname = nickname
    }
}
