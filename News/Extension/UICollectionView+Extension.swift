//
//  UICollectionView+Extension.swift
//  News
//
//  Created by 经纬泰和 on 2018/11/30.
//  Copyright © 2018 经纬泰和. All rights reserved.
//

import UIKit

extension UICollectionView {
    //注册cell
    func lwn_registerCell<T:UICollectionViewCell>(cell: T.Type) where T:RegisterCellOrNib {
        if let nib = T.nib {
            register(nib, forCellWithReuseIdentifier: T.identifier)
        }else {
            register(cell, forCellWithReuseIdentifier: T.identifier)
        }
    }
    
    
    func lwn_dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T where T:RegisterCellOrNib {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
    
}
