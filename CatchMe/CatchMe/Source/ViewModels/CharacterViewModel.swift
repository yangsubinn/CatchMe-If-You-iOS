//
//  CharacterViewModel.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/15.
//

import UIKit

import Moya

class CharacterViewModel {
    static var shared: CharacterViewModel = CharacterViewModel()
    
    private let authProvider = MoyaProvider<CharacterService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    private var editModel: EditCharacterModel?
    
    // MARK: - POST /character/edit
    func dispatchCharacterEdit(name: String, index: Int, privacy: Bool, vc: UIViewController) {
        let param = EditCharacterRequest.init(index, name, privacy)
        
        authProvider.request(.edit(param: param)) { response in
            switch response {
            case .success(let result):
                do {
                    self.editModel = try result.map(EditCharacterModel.self)
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
