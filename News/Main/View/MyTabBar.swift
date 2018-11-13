//
//  MyTabBar.swift
//  News
//
//  Created by 经纬泰和 on 2018/11/13.
//  Copyright © 2018 经纬泰和. All rights reserved.
//

import UIKit

class MyTabBar: UITabBar {


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(publishButton)
    }
    
    // private 绝对私有，除了在当前类中可以访问之外，其他任何类都不能访问或者这个类的扩展都不能访问
    //fileprivate 文件私有，可以在当前类文件中访问，其他文件不能访问
    //open 在任何类文件中都不能访问
    //internal 默认，可以不写
    
    private lazy var publishButton : UIButton = {
        
        let publishButton = UIButton(type: .custom)
        
        publishButton.setImage(UIImage(named: "feed_publish_44x44_"), for: .normal)
        
        publishButton.setImage(UIImage(named: "feed_publish_press_44x44_"), for: .selected)
        
        publishButton.sizeToFit()
        
        publishButton.addTarget(self, action: #selector(myPublishButtonAction), for: .touchUpInside)
        
        return publishButton
        
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func myPublishButtonAction() {
        print("点击了中间按钮")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //当前tabBar的宽度和高度
        let width = frame.width
        let height : CGFloat = 49.0
        
        publishButton.center = CGPoint(x: width*0.5, y: height*0.5 - 7)
        
        //设置button的frame
        let buttonW = width*0.2
        let buttonH: CGFloat = 49.0
        let buttonY = 0
        
        var index = 0
        for button in subviews {
            if !button.isKind(of: NSClassFromString("UITabBarButton")!) {continue}
            let buttonX = buttonW * (index > 1 ? CGFloat(index+1) : CGFloat(index) )
            button.frame = CGRect(x: buttonX, y: CGFloat(buttonY), width: buttonW, height: buttonH)
            index += 1
        }
        
    }
    
    
}
