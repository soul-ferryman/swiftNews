//
//  UITableView+Extension.swift
//  News
//
//  Created by 经纬泰和 on 2018/11/30.
//  Copyright © 2018 经纬泰和. All rights reserved.
//

import UIKit

extension UITableView {
    //注册cell
    func lwn_registerCell<T:UITableViewCell>(cell: T.Type) where T:RegisterCellOrNib {
        if let nib = T.nib {
            register(nib, forCellReuseIdentifier: T.identifier)
        }else {
            register(cell, forCellReuseIdentifier: T.identifier)
        }
    }

    
    func lwn_dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T:RegisterCellOrNib {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
    
}

