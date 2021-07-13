//
//  EmailCheckModel.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/13.
//

import Foundation

// MARK: - EmailCheckModel
struct EmailCheckModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: CheckData?
}

// MARK: - CheckData
struct CheckData: Codable {
    let duplicate: String
}
