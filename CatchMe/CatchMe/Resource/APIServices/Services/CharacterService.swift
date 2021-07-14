//
//  CharacterService.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/14.
//

import Foundation
import Moya

enum CharacterService {
    case characterDetail(Int)
}

extension CharacterService: TargetType {
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
        case .characterDetail(let param):
            return "/character/\(param)"
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .characterDetail:
            return JSONEncoding.default
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .characterDetail:
            return .get
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .characterDetail:
            return .requestPlain
        }
    }
//    requestParameters(parameters: try! param.asDictionary(), encoding: URLEncoding.default)
    var headers: [String: String]? {
        switch self {
        default:
            return ["Content-Type": "application/json",
                    "token": GeneralAPI.token]
        }
    }
}

