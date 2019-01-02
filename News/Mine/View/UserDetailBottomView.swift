//
//  UserDetailBottomView.swift
//  News
//
//  Created by 经纬泰和 on 2019/1/2.
//  Copyright © 2019 经纬泰和. All rights reserved.
//

import UIKit

protocol UserDetailBottomViewDelegate:class {
    func bottomView(clicked button:UIButton, bottomTab:BottomTab)
}

class UserDetailBottomView: UIView {
    
    weak var delegate:UserDetailBottomViewDelegate?
    
    var bottomTabs = [BottomTab](){
        didSet{
            
            let buttonWidth = CGFloat(ScreenWidth - CGFloat(bottomTabs.count)) / CGFloat(bottomTabs.count)
            
            
            for (index, bottomTab) in bottomTabs.enumerated() {
                //按钮
                let button = UIButton(frame: CGRect(x: CGFloat(index) * (buttonWidth+1), y: 0, width: buttonWidth, height: height))
                button.tag = index
                button.setTitle(bottomTab.name, for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                button.theme_setTitleColor("colors.black", forState: .normal)
                button.theme_setImage("images.tabbar-options", forState: .normal)
                button.addTarget(self, action: #selector(bottomTabButtonClicked), for: .touchUpInside)
                addSubview(button)
                
                //分割线
                if index < bottomTabs.count-1 {
                    let separatorView = UIView(frame: CGRect(x: button.frame.maxX, y: 6, width: 1, height: 32))
                    separatorView.backgroundColor = UIColor.lightGray
                    addSubview(separatorView)
                }
            }
            
        }
    }
    
    @objc func bottomTabButtonClicked(button:UIButton)  {
        
        let bottomTab = bottomTabs[button.tag]
        
        delegate?.bottomView(clicked: button, bottomTab: bottomTab)
        
    }
    

    override init(frame:CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
