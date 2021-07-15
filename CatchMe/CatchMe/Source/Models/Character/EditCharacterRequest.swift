//
//  EditCharacterRequest.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/15.
//

import Foundation

struct EditCharacterRequest: Codable {
    var characterIndex: Int
    var characterName: String
    var characterPrivacy: Bool
    
    init(_ characterIndex: Int, _ characterName: String, _ characterPrivacy: Bool) {
        self.characterIndex = characterIndex
        self.characterName = characterName
        self.characterPrivacy = characterPrivacy
    }
}
