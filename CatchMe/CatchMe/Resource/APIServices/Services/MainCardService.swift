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
        /// 나중에 실제로 accessToken이 들어오면 사용하기
        let accessToken = UserDefaultStorage.accessToken
        switch self {
        default:
            return ["Content-Type": "application/json",
                    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjBlNWQzMTE0ZjM3ZTliMjUyYzYwOGJlIn0sImlhdCI6MTYyNjI2MDUxMSwiZXhwIjoxNjI3NDcwMTExfQ.mAni2lnF47sgNnQinxi-DTT-Vknf6KP7CmhCBf5VmLI"]
        }
    }
}
//GeneralAPI.token
// 빈 데이터 eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjBlYzQ1NTMzNDdmZjMyZDNhMDg0YTcyIn0sImlhdCI6MTYyNjMwMDQxMywiZXhwIjoxNjI3NTEwMDEzfQ.lqBik9ioTP21UYyzRy9_iKV1rzLNnMg6RMNujVxnI2M
// 호호
//            eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjBlNWQzMTE0ZjM3ZTliMjUyYzYwOGJlIn0sImlhdCI6MTYyNjI2MDUxMSwiZXhwIjoxNjI3NDcwMTExfQ.mAni2lnF47sgNnQinxi-DTT-Vknf6KP7CmhCBf5VmLI
