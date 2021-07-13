//
//  CreateCharacterRequest.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/13.
//

import Foundation

struct CreateCharacterRequest: Codable {
    var characterName: String
    var characterImageIndex: Int
    var characterPrivacy: Bool
    
    init(_ characterName: String, _ characterImageIndex: Int, _ characterPrivacy: Bool) {
        self.characterName = characterName
        self.characterImageIndex = characterImageIndex
        self.characterPrivacy = characterPrivacy
    }
}
