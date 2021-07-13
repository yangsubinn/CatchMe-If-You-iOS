//
//  MainCardService.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/13.
//

import Moya

enum MainCardService {
    case create(param: CreateCharacterRequest)
}

extension MainCardService: TargetType {
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
        case .create:
            return "/maincard/create"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .create:
            return .post
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .create(let param):
            return .requestJSONEncodable(param)
        }
    }
    
    var headers: [String: String]? {
        /// 나중에 실제로 accessToken이 들어오면 사용하기
        let accessToken = UserDefaultStorage.accessToken
        switch self {
        default:
            return ["Content-Type": "application/json",
                    "token": GeneralAPI.token]
        }
    }
}

