//
//  MyHeaderView.swift
//  News
//
//  Created by 经纬泰和 on 2018/12/3.
//  Copyright © 2018 经纬泰和. All rights reserved.
//

import UIKit
import SwiftTheme

class MyHeaderView: UIView {
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var mobileButton: UIButton!
    @IBOutlet weak var wechatButton: UIButton!
    @IBOutlet weak var qqButton: UIButton!
    @IBOutlet weak var sinaButton: UIButton!
    @IBOutlet weak var moreLoginButton: UIButton!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var daysOrNightButton: UIButton!
    
    @IBOutlet weak var favouriteImageView: UIImageView!
    @IBOutlet weak var historyImageView: UIImageView!
    @IBOutlet weak var dayOrNightImageView: UIImageView!
    
    
    var dayOrNightSelect:Bool = false
    
    
    //点击了日间夜间按钮
    @IBAction func dayOrNightButtonClicked(_ sender: UIButton) {
        dayOrNightSelect = !dayOrNightSelect
        MyTheme.switchNight(dayOrNightSelect)
    }
    
    class func headerView()-> MyHeaderView {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.last as! MyHeaderView
        
    }

    override func awakeFromNib() {
        
        
        
        ThemeManager.setTheme(plistName: "default_theme", path: .mainBundle)
        
        //设置主题
        
        mobileButton.theme_setImage("images.loginMobileButton", forState: .normal)
        wechatButton.theme_setImage("images.loginWechatButton", forState: .normal)
        qqButton.theme_setImage("images.loginQQButton", forState: .normal)
        sinaButton.theme_setImage("images.loginSinaButton", forState: .normal)
        favouriteImageView.theme_image = "images.mineFavoriteButton"
        historyImageView.theme_image = "images.mineHistoryButton"
        dayOrNightImageView.theme_image = "images.dayOrNightButton"
        
    }

}
