//
//  SignupModel.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/13.
//

import Foundation

// MARK: - SignupModel
struct SignupModel: Codable {
    let status: Int
    let success: Bool
    let message: String
}
