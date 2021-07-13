//
//  SigninModel.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/13.
//

import Foundation

// MARK: - SigninModel
struct SigninModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: LoginData?
}

// MARK: - DataClass
struct LoginData: Codable {
    let token: String
}
