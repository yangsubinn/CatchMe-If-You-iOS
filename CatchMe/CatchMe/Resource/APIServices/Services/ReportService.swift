//
//  ReportService.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/15.
//

import Moya

enum ReportService {
    case report(Int, String)
}

extension ReportService: TargetType {
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
        case .report(let year, let month):
            return "/report/\(year)/\(month)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .report:
            return .get
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .report:
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
