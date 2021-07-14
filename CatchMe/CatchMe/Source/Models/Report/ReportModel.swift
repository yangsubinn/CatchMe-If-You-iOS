//
//  ReportModel.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/15.
//

import Foundation

// MARK: - ReportModel
struct ReportModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: ReportData?
}

// MARK: - ReportData
struct ReportData: Codable {
    let characterName: String
    let characterIndex, characterImageIndex, characterLevel, catching: Int
    let activitiesOfMonth: [ActivitiesOfMonth]
    let characterIndexArr, characterLevelArr: [Int]
}

// MARK: - ActivitiesOfMonth
struct ActivitiesOfMonth: Codable {
    let activityIndex: Int
    let activityYear, activityMonth, activityDay: String
    let characterIndex: Int
}
