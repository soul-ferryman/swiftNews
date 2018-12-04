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
    
    @IBOutlet weak var moreLofinView: UIView!
    @IBOutlet weak var moreLoginLabel: UILabel!
    @IBOutlet weak var dayOrNightLabel: UILabel!
    @IBOutlet weak var favourateLabel: UILabel!
    
    @IBOutlet weak var historyLabel: UILabel!
    var dayOrNightSelect:Bool = UserDefaults.standard.bool(forKey: isNight)
    
    
    //点击了日间夜间按钮
    @IBAction func dayOrNightButtonClicked(_ sender: UIButton) {
        dayOrNightSelect = !dayOrNightSelect
        
        UserDefaults.standard.set(dayOrNightSelect, forKey: "isNight")
//        UserDefaults.standard.synchronize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: dayOrNight), object: dayOrNightSelect)
        
        if dayOrNightSelect == true {
            dayOrNightLabel.text = "日间"
        }else {
            dayOrNightLabel.text = "夜间"
        }
        MyTheme.switchNight(dayOrNightSelect)
        
    }
    
    class func headerView()-> MyHeaderView {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.last as! MyHeaderView
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //设置主题
        
        mobileButton.theme_setImage("images.loginMobileButton", forState: .normal)
        wechatButton.theme_setImage("images.loginWechatButton", forState: .normal)
        qqButton.theme_setImage("images.loginQQButton", forState: .normal)
        sinaButton.theme_setImage("images.loginSinaButton", forState: .normal)
        favouriteImageView.theme_image = "images.mineFavoriteButton"
        historyImageView.theme_image = "images.mineHistoryButton"
        dayOrNightImageView.theme_image = "images.dayOrNightButton"
        if dayOrNightSelect == true {
            dayOrNightLabel.text = "日间"
        }else {
            dayOrNightLabel.text = "夜间"
        }
        
        moreLofinView.theme_backgroundColor = "colors.moreLoginBackgroundColor"
        moreLoginLabel.theme_textColor = "colors.moreLoginTextColor"
        favourateLabel.theme_textColor = "colors.black"
        historyLabel.theme_textColor = "colors.black"
        dayOrNightLabel.theme_textColor = "colors.black"
        
        favouriteButton.theme_backgroundColor = "colors.cellBackfroundColor"
        historyButton.theme_backgroundColor = "colors.cellBackfroundColor"
        daysOrNightButton.theme_backgroundColor = "colors.cellBackfroundColor"
    }

}
