//
//  AddActionNewService.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/15.
//

import Foundation
import Alamofire

struct AddActionNewService {
    
    static let shared = AddActionNewService()
    
    func uploadNewActivity (imageData: UIImage?,
                            content: String,
                            year: String,
                            month: String,
                            day: String,
                            index: Int,
                            completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.newURL
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjBlNWQzMTE0ZjM3ZTliMjUyYzYwOGJlIn0sImlhdCI6MTYyNjM1NzM3NywiZXhwIjoxNjI3NTY2OTc3fQ.LTRShmdY60bZJZqqYHv5BIYVIJGgfm6sDpXnXGWbq1s"
        let header : HTTPHeaders = [
            "Content-Type" : "multipart/form-data",
            "token" : token
        ]
        
        let parameters: [String : Any] = [
            "activityContent": content,
            "activityYear": year,
            "activityMonth": month,
            "activityDay": day,
            "characterIndex": index
        ]
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
            }
            if let image = imageData?.pngData() {
                multipartFormData.append(image, withName: "activityImage", fileName: "\(image).png", mimeType: "image/png")
            }
        }, to: URL, usingThreshold: UInt64.init(), method: .post, headers: header).response { response in
            guard let statusCode = response.response?.statusCode,
                  statusCode == 200
            else { return }
            completion(.success(statusCode))
        }
    }
}




