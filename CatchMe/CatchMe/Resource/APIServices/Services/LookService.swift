//
//  LookService.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/15.
//

import Moya

enum LookService {
    case other
    case detail(String, Int)
}

extension LookService: TargetType {
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }

    var path: String {
        switch self {
        case .other:
            return "/other"
        case .detail(let userID, let index):
            return "/other/detail/?\(userID)/?\(index)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .other,
             .detail:
            return .get
        }
    }

    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }

    var task: Task {
        switch self {
        case .other:
            return .requestPlain
        case .detail(let userID, let index):
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        default:
            return ["Content-Type": "application/json",
                    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjBlNWQzMTE0ZjM3ZTliMjUyYzYwOGJlIn0sImlhdCI6MTYyNjI2MDUxMSwiZXhwIjoxNjI3NDcwMTExfQ.mAni2lnF47sgNnQinxi-DTT-Vknf6KP7CmhCBf5VmLI"] // GeneralAPI.token
        }
    }
}
