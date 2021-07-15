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
    private var passwordCheckModel: SettingModel?
    
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
    func dispatchPasswordCheck(password: String, completion: @escaping (() -> ())) {
        let param = PasswordRequest.init(password)
        
        authProvider.request(.passwordCheck(param: param)) { response in
            switch response {
            case .success(let result):
                do {
                    self.passwordCheckModel = try result.map(SettingModel.self)
                    
                    completion()
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
