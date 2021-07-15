//
//  LookModel.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/15.
//

import Foundation

// MARK: - LookModel
struct LookModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [OtherCharacter]?
}

// MARK: - OtherCharacter
struct OtherCharacter: Codable {
    let userID, userNickname, characterName: String
    let characterIndex, characterImageIndex: Int
    let characterPrivacy: Bool
    let characterLevel: Int
    let characterBirth: String
    let activityCount: Int
    let recentActivityTime: String?
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case userNickname = "user_nickname"
        case characterName, characterIndex, characterImageIndex, characterPrivacy, characterLevel, characterBirth, activityCount, recentActivityTime
    }
}
