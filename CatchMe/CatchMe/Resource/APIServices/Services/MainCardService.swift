//
//  MainCardService.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/13.
//

import Moya

enum MainCardService {
    case recentActivity
    case most
    case recentCreate
    case create(param: CreateCharacterRequest)
}

extension MainCardService: TargetType {
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
        case .recentActivity:
            return "/maincard"
        case .most:
            return "/maincard/most"
        case .recentCreate:
            return "/maincard/recent"
        case .create:
            return "/maincard/create"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .recentActivity,
             .most,
             .recentCreate:
            return .get
        case .create:
            return .post
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .recentActivity,
             .most,
             .recentCreate:
            return .requestPlain
        case .create(let param):
            return .requestJSONEncodable(param)
        }
    }
    
    var headers: [String: String]? {
        let accessToken = UserDefaultStorage.accessToken
        switch self {
        default:
            return ["Content-Type": "application/json",
                    "token": accessToken]
        }
    }
}
