//
//  LookService.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/15.
//

import Moya

enum LookService {
    case other
    case otherDetail(String, Int)
}

extension LookService: TargetType {
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }

    var path: String {
        switch self {
        case .other:
            return "/other"
        case .otherDetail(let userID, let index):
            return "/other/detail/\(userID)/\(index)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .other,
             .otherDetail:
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
        case .otherDetail(let userID, let index):
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        let accessToken = UserDefaultStorage.accessToken
        switch self {
        default:
            return ["Content-Type": "application/json",
                    "token": accessToken] // GeneralAPI.token
        }
    }
}
