//
//  MainModel.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/14.
//

import Foundation

// MARK: - MainModel
struct MainModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [MainCharacter]?
}

// MARK: - MainCharacter
struct MainCharacter: Codable {
    let userNickname, characterName: String
    let characterIndex, characterImageIndex, characterLevel, activityCount: Int
    let countPercentage: Int?
    
    enum CodingKeys: String, CodingKey {
            case userNickname = "user_nickname"
            case characterName, characterIndex, characterImageIndex, characterLevel, activityCount, countPercentage
        }
}
