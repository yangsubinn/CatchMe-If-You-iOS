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
    
    let mainTableView = UITableView(frame: .zero, style: .plain)
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        setupAutoLayout()
    }
    
    // MARK: - setTableView
    
    func setTableView() {
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        mainTableView.register(CharacterReportTVC.self, forCellReuseIdentifier: "CharacterReportTVC")
        mainTableView.register(CharacterTVC.self, forCellReuseIdentifier: "CharacterTVC")
        
        mainTableView.separatorStyle = .none
        
    }
    
    // MARK: - setAutoLayout
    
    func setupAutoLayout() {
        
        view.addSubviews([upperView, mainTableView, naviBar])
        
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
    
    
}

// MARK: - UITableViewDataSource

extension CharacterVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterReportTVC", for: indexPath) as? CharacterReportTVC else { return UITableViewCell() }
        
        return cell
     }
    
    
}
