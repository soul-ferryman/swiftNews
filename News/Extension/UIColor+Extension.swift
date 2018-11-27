//
//  UIColor+Extension.swift
//  News
//
//  Created by 经纬泰和 on 2018/11/26.
//  Copyright © 2018 经纬泰和. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r:CGFloat , g:CGFloat , b:CGFloat, alpha:CGFloat = 1.0) {
    
        
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
        
//        self.init(displayP3Red: r, green: g, blue: b, alpha: alpha)
        
        
    }
    
    
    convenience init(rgbValueFromHex:(Int)) {
        
        self.init(red: CGFloat(((Float)((rgbValueFromHex & 0xFF0000) >> 16))/255.0), green: CGFloat(((Float)((rgbValueFromHex & 0x00FF00) >> 8))/255.0), blue: CGFloat(((Float)((rgbValueFromHex & 0x0000FF) >> 0))/255.0), alpha: 1.0)
    }
    
    class func globalBackgroundColor() -> UIColor {
        return UIColor(r: 248, g: 249, b: 247)
    }
    
}
