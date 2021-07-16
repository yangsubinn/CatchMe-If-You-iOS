//
//  AddActionDeleteService.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/16.
//

import Foundation
import Alamofire

struct AddActionDeleteService {
    
    static let shared = AddActionDeleteService()
    
    func deleteActivity (index: Int,
                         activityIndex: Int,
                         completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.deleteURL
        let token = UserDefaultStorage.accessToken
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "token": token
        ]
        let parameters: [String : Int] = [
            "characterIndex": index,
            "activityIndex": activityIndex
        ]
        
        let dataRequest = AF.request(URL,
                                     method: .post,
                                     parameters: parameters,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.value else { return }
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)
            case .failure: completion(.pathErr)
            }
        }
    }
    
    private func judgeStatus(by statusCode : Int, _ data : Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(AddActionModel.self, from: data)
        else { return .pathErr }
        switch statusCode {
        case 200: return .success(decodedData.message)
        case 400: return .requestErr(decodedData.message)
        case 500: return .serverErr
        default: return .networkFail
        }
    }  
}
