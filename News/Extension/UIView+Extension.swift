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

extension UIView {
    
    var x : CGFloat {
        get{ return frame.origin.x}
        set(newValue){
            var tempFrame:CGRect = frame
            tempFrame.origin.x = newValue
            frame = tempFrame
        }
    }
    
    var y : CGFloat {
        get{ return frame.origin.y}
        set(newValue){
            var tempFrame:CGRect = frame
            tempFrame.origin.y = newValue
            frame = tempFrame
        }
    }
    
    var height : CGFloat {
        get{ return frame.size.height}
        set(newValue){
            var tempFrame:CGRect = frame
            tempFrame.size.height = newValue
            frame = tempFrame
        }
    }
    
    var width : CGFloat {
        get{ return frame.size.width}
        set(newValue){
            var tempFrame:CGRect = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    
    var size : CGSize {
        get{ return frame.size}
        set(newValue){
            var tempFrame:CGRect = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
    
    var centerX : CGFloat {
        get{ return center.x}
        set(newValue){
            var tempCenter:CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    var centerY : CGFloat {
        get{ return center.y}
        set(newValue){
            var tempCenter:CGPoint = center
            tempCenter.y = newValue
            center = tempCenter
        }
    }
    
    
}




