//
//  LookDetailModel.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/16.
//

// MARK: - LookDetailModel
struct LookDetailModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: LookDetail
}

// MARK: - LookDetail
struct LookDetail: Codable {
    let userID, userNickname, characterName: String
    let characterIndex, characterImageIndex: Int
    let characterPrivacy: Bool
    let characterLevel: Int
    let characterBirth: String
    let activityCount: Int
    let activity: [Activity]?
    let recentActivityTime: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case userNickname = "user_nickname"
        case characterName, characterIndex, characterImageIndex,
             characterPrivacy, characterLevel, characterBirth,
             activityCount, activity, recentActivityTime
    }
}

// MARK: - Activity
struct Activity: Codable {
    let id: String
    let activityIndex: Int
    let activityContent: String
    let activityImage: String
    let activityYear, activityMonth, activityDay: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case activityIndex, activityContent, activityImage,
             activityYear, activityMonth, activityDay
    }
}
