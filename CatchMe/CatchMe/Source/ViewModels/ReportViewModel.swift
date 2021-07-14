//
//  ReportViewModel.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/15.
//

import UIKit

import Moya

class ReportViewModel {
    static var shared: ReportViewModel = ReportViewModel()
    
    private let authProvider = MoyaProvider<ReportService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    private var reportModel: ReportModel?
    
    // MARK: - POST /maincard/create
    func fetchReport(year: Int, month: Int, completion: @escaping ((ReportData?) -> ())) {
        authProvider.request(.report(year, month)) { response in
            switch response {
            case .success(let result):
                do {
                    self.reportModel = try result.map(ReportModel.self)
                    
                    completion(self.reportModel?.data)
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
