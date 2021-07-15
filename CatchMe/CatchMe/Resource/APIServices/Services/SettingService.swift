//
//  SettingService.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/15.
//

import Foundation
import Moya

enum SettingService {
    case nickname(param: NicknameRequest)
    case password(param: PasswordRequest)
    case passwordCheck(param: PasswordRequest)
    case withdraw
}

extension SettingService: TargetType {
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
        case .nickname:
            return "/setting/nickname"
        case .password:
            return "/setting/password"
        case .passwordCheck:
            return "/setting/passwordcheck"
        case .withdraw:
            return "/setting/withdraw"
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .nickname,
             .password,
             .passwordCheck,
             .withdraw:
            return JSONEncoding.default
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .nickname,
             .password,
             .passwordCheck,
             .withdraw:
            return .post
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .nickname(let param):
            return .requestJSONEncodable(param)
        case .password(let param):
            return .requestJSONEncodable(param)
        case .passwordCheck(let param):
            return .requestJSONEncodable(param)
        case .withdraw:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        default:
            return ["Content-Type": "application/json",
                    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjBmMDQ2ZDVmMTY3YWM2YTJmODJlYjM5In0sImlhdCI6MTYyNjM2MDM0MCwiZXhwIjoxNjI3NTY5OTQwfQ.LA-kNqFCE32SaI7lFQ-AzSzw9CK-MzSlnCy92cje_g0"]
        }
    }
}
