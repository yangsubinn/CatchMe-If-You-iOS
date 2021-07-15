//
//  AddActionModel.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/15.
//

import Foundation

// MARK: - AddActionModel
struct AddActionModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = (try? values.decode(Int.self, forKey: .status)) ?? 0
        success = (try? values.decode(Bool.self, forKey: .success)) ?? true
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
    }
}
