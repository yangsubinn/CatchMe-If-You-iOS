//
//  RecentActivityModel.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/15.
//

import Foundation

// MARK: - RecentActivityModel
struct RecentActivityModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [RecentActivity]?
}

// MARK: - RecentActivity
struct RecentActivity: Codable {
    let characterName: String
    let characterIndex, characterImageIndex: Int
    let characterPrivacy: Bool
    let characterLevel: Int
    let characterBirth: String
    let activityCount: Int
    let recentActivityTime: String
}
