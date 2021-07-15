//
//  PasswordCheckModel.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/15.
//

import Foundation

// MARK: - PasswordCheckModel
struct PasswordCheckModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: PasswordData?
}

struct PasswordData: Codable {
    let check: String
}
