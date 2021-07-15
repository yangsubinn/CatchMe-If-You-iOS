//
//  AddActionService.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/15.
//

import Alamofire
import Moya

enum AddActionService {
    case new(param: NewRequest)
    case edit(param: SignupRequest)
    case delete(param: SigninRequest)
}

extension AddActionService: TargetType {
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
        case .new:
            return "/activity/new"
        case .edit:
            return "/activity/edit"
        case .delete:
            return "/activity/delete"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .new,
             .edit,
             .delete:
            return .post
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .new(let param):
            return .requestJSONEncodable(param)
        case .edit(let param):
            return .requestJSONEncodable(param)
        case .delete(let param):
            return .requestJSONEncodable(param)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return ["Content-Type": "application/json",
                    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjBlNWQzMTE0ZjM3ZTliMjUyYzYwOGJlIn0sImlhdCI6MTYyNjI2MDUxMSwiZXhwIjoxNjI3NDcwMTExfQ.mAni2lnF47sgNnQinxi-DTT-Vknf6KP7CmhCBf5VmLI"]
        }
    }
}
