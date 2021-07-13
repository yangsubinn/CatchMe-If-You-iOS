//
//  LoginService.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/13.
//

import Moya

enum LoginService {
    case signUp(param: SignupRequest)
    case signIn(param: SigninRequest)
    case emailCheck(param: EmailCheckRequest)
}

extension LoginService: TargetType {
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
        case .signUp:
            return "/user/signup"
        case .signIn:
            return "/user/login"
        case .emailCheck:
            return "/user/emailcheck"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signUp,
             .signIn,
             .emailCheck:
            return .post
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .signUp(let param):
            return .requestJSONEncodable(param)
        case .signIn(let param):
            return .requestJSONEncodable(param)
        case .emailCheck(let param):
            return .requestJSONEncodable(param)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
