//
//  LoginViewModel.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/13.
//

import UIKit

import Moya

extension Notification.Name {
    static let signupVC = Notification.Name("signupVC")
}

class LoginViewModel {
    static var shared: LoginViewModel = LoginViewModel()
    
    private let authProvider = MoyaProvider<LoginService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    private var signinModel: SigninModel?
    private var signupModel: SignupModel?
    private var emailcheckModel: EmailCheckModel?
    
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
                            
                            if let token = self.signinModel?.data?.token,
                               let nickname = self.signinModel?.data?.nickname {
                                Login.shared.setLogin(token: token, nickname: nickname)
                            }
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
    
    // MARK: - POST /user/signup
    func dispatchSignup(email: String, nickname: String, password: String, vc: UIViewController) {
        let param = SignupRequest.init(email, nickname, password)
        
        authProvider.request(.signUp(param: param)) { response in
            switch response {
            case .success(_):
                do {
                    NotificationCenter.default.post(name: .signupVC, object: nil, userInfo: ["username": email, "userpw": password])
                    
                    vc.navigationController?.popViewController(animated: true)
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    // MARK: - POST /user/emailcheck
    func dispatchEmailCheck(email: String, completion: @escaping ((Int) -> Void)) {
        var duplicate = 0
        let param = EmailCheckRequest.init(email)
        
        authProvider.request(.emailCheck(param: param)) { response in
            switch response {
            case .success(let result):
                do {
                    self.emailcheckModel = try result.map(EmailCheckModel.self)
                    
                    if let emailDuplicate = self.emailcheckModel?.data?.duplicate {
                        if emailDuplicate == "available" {
                            duplicate = 1
                        } else {
                            duplicate = 0
                        }
                    }
                    
                    completion(duplicate)
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
                duplicate = 3
                
                completion(duplicate)
            }
        }
    }
}
