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

    
    /// 背景灰色 f8f9f7
    class func globalBackgroundColor() -> UIColor {
        return UIColor(r: 248, g: 249, b: 247)
    }
    
    /// 背景红色
    class func globalRedColor() -> UIColor {
        return UIColor(r: 196, g: 73, b: 67)
    }
    
    /// 字体蓝色
    class func blueFontColor() -> UIColor {
        return UIColor(r: 72, g: 100, b: 149)
    }
    
    /// 背景灰色 132
    class func grayColor132() -> UIColor {
        return UIColor(r: 132, g: 132, b: 132)
    }
    
    /// 背景灰色 232
    class func grayColor232() -> UIColor {
        return UIColor(r: 232, g: 232, b: 232)
    }
    
    /// 夜间字体背景灰色 113
    class func grayColor113() -> UIColor {
        return UIColor(r: 113, g: 113, b: 113)
    }
    
    /// 夜间背景灰色 37
    class func grayColor37() -> UIColor {
        return UIColor(r: 37, g: 37, b: 37)
    }
    
    /// 灰色 210
    class func grayColor210() -> UIColor {
        return UIColor(r: 210, g: 210, b: 210)
    }
    
}
