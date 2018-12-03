//
//  MyTheme.swift
//  News
//
//  Created by 经纬泰和 on 2018/12/3.
//  Copyright © 2018 经纬泰和. All rights reserved.
//

import Foundation
import SwiftTheme

enum MyTheme:Int
{
    case day = 0
    
    case night = 1
    
    static var before = MyTheme.day
    static var current = MyTheme.day
    
    //选择主题
    static func switchTo(_ theme:MyTheme) {
        before = current
        current = theme
        
        switch theme {
        case .day:ThemeManager.setTheme(plistName: "default_theme", path:.mainBundle)
        case .night:ThemeManager.setTheme(plistName: "night_theme", path:.mainBundle)
        
        }
    }
    
    //选择夜间
    static func switchNight(_ isToNight:Bool) {
        switchTo(isToNight ? .night : .day)
    }
    
    //判断当前是否是夜间主题
    static func isNight() -> Bool {
        return current == .night
    }
    
}
