//
//  CharacterVC.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/02.
//

import UIKit

class CharacterVC: UIViewController {
    
    // MARK: - Property
    let naviBar = NavigationBar()
    
    let upperView = CharacterUpperView()
    
    let mainTableView = UITableView(frame: .zero, style: .grouped)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAutoLayout()
        setTableView()
        
    }
    
    // MARK: - Custom Method
    func setTableView() {
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        mainTableView.register(CharacterReportTVC.self, forCellReuseIdentifier: "CharacterReportTVC")
        mainTableView.register(CharacterTVC.self, forCellReuseIdentifier: "CharacterTVC")
        
        mainTableView.separatorStyle = .none
        
        mainTableView.tableFooterView = UIView(frame: .zero)
        mainTableView.sectionFooterHeight = 0
        
    }
    
    func setupAutoLayout() {
        
        view.addSubviews([mainTableView, upperView, naviBar])
        
        naviBar.snp.makeConstraints { (make) in
            make.top.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        upperView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width)
        }
        
        mainTableView.snp.makeConstraints { (make) in
            make.top.equalTo(upperView.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }

}

// MARK: - UITableViewDelegate
extension CharacterVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return CharacterHeaderView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 126
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch indexPath.row {
//        case 0:
//            return 67
//        default:
//            return 200
//        }
//    }
}

// MARK: - UITableViewDataSource
extension CharacterVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            
            return 1 + 20
            
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                guard let reportCell = tableView.dequeueReusableCell(withIdentifier: "CharacterReportTVC", for: indexPath) as? CharacterReportTVC else { return UITableViewCell() }
                reportCell.backgroundColor = .green
                reportCell.setupAutoLayout()
                return reportCell
                
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTVC", for: indexPath) as? CharacterTVC else { return UITableViewCell() }
                cell.backgroundColor = .yellow
                cell.setupAutoLayout()
                return cell
            }
            
        default:
            return UITableViewCell()
        }
        
        
     }
    
    
}
