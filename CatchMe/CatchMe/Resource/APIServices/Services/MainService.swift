//
//  MainService.swift
//  CatchMe
//
//  Created by μμλΉ on 2021/07/14.
//

import Moya

enum MainService {
    case main
}

extension MainService: TargetType {
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
        case .main:
            return "/main"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .main:
            return .get
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .main:
            return .requestPlain
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
