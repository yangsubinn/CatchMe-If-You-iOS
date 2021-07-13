//
//  LoginViewModel.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/13.
//

import UIKit

import Moya

class LoginViewModel {
    static var shared: LoginViewModel = LoginViewModel()
    
    private let authProvider = MoyaProvider<LoginService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    private var signinModel: SigninModel?
    
    // MARK: - POST /user/login
    func dispatchLogin(email: String, password: String, completion: @escaping ((Int) -> Void)) {
        var success = 0
        let param = SigninRequest.init(email, password)
        
        authProvider.request(.signIn(param: param)) { response in
            switch response {
            case .success(let result):
                do {
                    self.signinModel = try result.map(SigninModel.self)
                    
                    if let text = self.signinModel?.message,
                       let dataSuccess = self.signinModel?.success {
                        if text == "비밀번호가 일치하지 않습니다." && !dataSuccess {
                            success = 412
                       } else if !dataSuccess {
                            success = 400
                       } else {
                            success = 200
                       }
                    }
                    
                    completion(success)
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
                success = 500
            }
        }
    }
}
