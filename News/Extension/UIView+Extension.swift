//
//  UIView+Extension.swift
//  News
//
//  Created by 经纬泰和 on 2018/11/30.
//  Copyright © 2018 经纬泰和. All rights reserved.
//

import UIKit

protocol RegisterCellOrNib {}

extension RegisterCellOrNib {
    static var identifier:String {
       
        return "\(self)"
    }
    
    static var nib:UINib? {
        return UINib(nibName: "\(self)", bundle: nil)
    }
}




