//
//  CharacterModel.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/14.
//

import Foundation

// MARK: - CharacterModel
struct CharacterModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: CharacterReportData
}

// MARK: - CharacterReportData
struct CharacterReportData: Codable {
    let character: CharacterDetail
    let characterActivitiesCount, catchRate: Int  
}

// MARK: - CharacterDetail
struct CharacterDetail: Codable {
    let characterName: String
    let characterIndex, characterImageIndex: Int
    let characterPrivacy: Bool
    let characterLevel: Int
    let characterBirth: String
    let activityCount: Int
    let activity: [ActivityDetail]?
    let recentActivityTime: String?
}

// MARK: - Activity
struct ActivityDetail: Codable {
    let id: String
    let activityIndex: Int
    let activityContent: String
    let activityImage: String
    let activityYear, activityMonth, activityDay: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case activityIndex, activityContent, activityImage, activityYear, activityMonth, activityDay
    }
}
