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
    case edit(param: EditCharacterRequest)
}

extension CharacterService: TargetType {
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
        case .characterDetail(let param):
            return "/character/\(param)"
        case .edit:
            return "/character/edit"
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .characterDetail,
             .edit:
            return JSONEncoding.default
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .characterDetail:
            return .get
        case .edit:
            return .post
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .characterDetail:
            return .requestPlain
        case .edit(let param):
            return .requestJSONEncodable(param)
        }
    }

    var headers: [String: String]? {
        let accessToken = UserDefaultStorage.accessToken
        switch self {
        default:
            return ["Content-Type": "application/json",
                    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjBlNWQzMTE0ZjM3ZTliMjUyYzYwOGJlIn0sImlhdCI6MTYyNjM1NzM3NywiZXhwIjoxNjI3NTY2OTc3fQ.LTRShmdY60bZJZqqYHv5BIYVIJGgfm6sDpXnXGWbq1s"]
        }
    }
}

