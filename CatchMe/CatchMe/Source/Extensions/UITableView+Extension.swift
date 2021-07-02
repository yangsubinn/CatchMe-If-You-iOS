//
//  UITableView+Extension.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/02.
//

import UIKit

extension UITableView{
    func setupTableViewNib(nib: String){
        let customNib = UINib(nibName: nib, bundle: nil)
        self.register(customNib, forCellReuseIdentifier: nib)
    }
}
