//
//  MainService.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/14.
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
        switch self {
        default:
            return ["Content-Type": "application/json",
                    "token": GeneralAPI.token] // "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjBlZDMzMWJkN2Y5ZjAzNWE5ODg1YmIxIn0sImlhdCI6MTYyNjI4MTA2MCwiZXhwIjoxNjI3NDkwNjYwfQ.cpSUdERjBij7OXnsR5d1DPizfm257iyPREmOKppW_fg"
        }
    }
}
