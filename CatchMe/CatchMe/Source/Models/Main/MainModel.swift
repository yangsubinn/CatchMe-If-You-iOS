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
    let data: [MainCharacter]
}

// MARK: - MainCharacter
struct MainCharacter: Codable {
    let characterName: String
    let characterIndex, characterImageIndex, characterLevel, activityCount: Int
    let countPercentage: Int
}
