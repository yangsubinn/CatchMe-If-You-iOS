//
//  MainCardViewModel.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/13.
//

import UIKit

import Moya

class MainCardViewModel {
    static var shared: MainCardViewModel = MainCardViewModel()
    
    private let authProvider = MoyaProvider<MainCardService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    private var createModel: CreateCharacterModel?
    
    // MARK: - POST /maincard/create
    func dispatchCreateCharacter(name: String, index: Int, privacy: Bool, vc: UIViewController) {
        let param = CreateCharacterRequest.init(name, index, privacy)
        
        authProvider.request(.create(param: param)) { response in
            switch response {
            case .success(let result):
                do {
                    self.createModel = try result.map(CreateCharacterModel.self)
                    
                    /// 뷰 연결하고 나면 뷰 dismiss하는 action 추가
                    // vc.dismiss(animated: true, completion: nil)
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
