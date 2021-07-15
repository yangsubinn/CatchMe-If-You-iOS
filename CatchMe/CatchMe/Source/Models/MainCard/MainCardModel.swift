//
//  MainCardModel.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/15.
//

import Foundation

// MARK: - MainCardModel
struct MainCardModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [CardCharacter]?
}

// MARK: - CardCharacter
struct CardCharacter: Codable {
    let characterName: String
    let characterIndex, characterImageIndex: Int
    let characterPrivacy: Bool
    let characterLevel: Int
    let characterBirth: String
    let activityCount: Int
    let recentActivityTime: String?
}
