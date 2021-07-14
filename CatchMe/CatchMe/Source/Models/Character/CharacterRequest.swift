//
//  CharacterRequest.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/14.
//

import Foundation

struct CharacterRequest: Codable {
    var characterIndex: Int
    
    init(_ index: Int) {
        self.characterIndex = index
    }
}
