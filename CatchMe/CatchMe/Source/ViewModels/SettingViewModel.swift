//
//  SettingViewModel.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/15.
//

import UIKit

import Moya

class SettingViewModel {
    static var shared: SettingViewModel = SettingViewModel()
    
    private let authProvider = MoyaProvider<SettingService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    private var nicknameModel: SettingModel?
    private var passwordCheckModel: PasswordCheckModel?
    private var passwordModel: SettingModel?
    private var withdrawModel: SettingModel?
    
    // MARK: - POST /setting/nickname
    func dispatchNickname(name: String, completion: @escaping (() -> ())) {
        let param = NicknameRequest.init(name)
        
        authProvider.request(.nickname(param: param)) { response in
            switch response {
            case .success(let result):
                do {
                    self.nicknameModel = try result.map(SettingModel.self)
                    
                    completion()
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    // MARK: - POST /setting/passwordcheck
    func dispatchPasswordCheck(password: String, completion: @escaping ((String) -> ())) {
        let param = PasswordRequest.init(password)
        
        authProvider.request(.passwordCheck(param: param)) { response in
            switch response {
            case .success(let result):
                do {
                    self.passwordCheckModel = try result.map(PasswordCheckModel.self)
                    
                    completion(self.passwordCheckModel?.data?.check ?? "false")
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    // MARK: - POST /setting/password
    func dispatchPassword(password: String, completion: @escaping ((Bool) -> ())) {
        let param = PasswordRequest.init(password)
        
        authProvider.request(.password(param: param)) { response in
            switch response {
            case .success(let result):
                do {
                    self.passwordModel = try result.map(SettingModel.self)
                    
                    completion(self.passwordModel?.success ?? false)
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    // MARK: - POST /setting/withdraw
    func dispatchWithdraw() {
        authProvider.request(.withdraw) { response in
            switch response {
            case .success(let result):
                do {
                    self.withdrawModel = try result.map(SettingModel.self)
                    
                    Login.shared.setLoginOut()
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
