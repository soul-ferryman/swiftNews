//
//  NavigationBarView.swift
//  News
//
//  Created by 经纬泰和 on 2019/1/3.
//  Copyright © 2019 经纬泰和. All rights reserved.
//

import UIKit
import IBAnimatable

class NavigationBarView: UIView , NibLoadable{
    
    var userDetail:UserDetail? {
        didSet{
            nameLabel.text = userDetail!.screen_name
            concernButton.isSelected = userDetail!.is_following
            concernButton.theme_backgroundColor = userDetail!.is_following ? "colors.userDetailFollowingConcernBtnBgColor" : "colors.globalRedColor"
            concernButton.borderColor = userDetail!.is_following ? .grayColor232() : .globalRedColor()
            concernButton.borderWidth = userDetail!.is_following ? 1 : 0
        }
    }
    

    @IBOutlet weak var statusBarView: UIView!
    @IBOutlet weak var navigetionBar: UIView!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var concernButton: AnimatableButton!
    @IBAction func concernButtonClicked(_ sender: AnimatableButton) {
        
        if sender.isSelected {
            //已经关注，点击取消关注
            NetworkTool.loadRelationUnfollow(user_id: userDetail!.user_id) { (_) in
                sender.isSelected = !sender.isSelected
                self.concernButton.theme_backgroundColor = "colors.globalRedColor"
                
            }
            
        }else {
            //未关注，点击则关注
            NetworkTool.loadRelationFollow(user_id: userDetail!.user_id) { (_) in
                //
                sender.isSelected = !sender.isSelected
                self.concernButton.theme_backgroundColor =  "colors.userDetailFollowingConcernBtnBgColor"
               
            }
        }
        
    }
    var goBackClicked: (()->())?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        returnButton.theme_setImage("images.personal_home_back_white_24x24_", forState: .normal)
        moreButton.theme_setImage("images.new_morewhite_titlebar_22x22_", forState: .normal)
        concernButton.setTitle("关注", for: .normal)
        concernButton.setTitle("已关注", for: .selected)
        concernButton.theme_setTitleColor("colors.userDetailConcernButtonTextColor", forState: .normal)
        concernButton.theme_setTitleColor("colors.userDetailConcernButtonSelectedTextColor", forState: .selected)
    }

    @IBAction func returnButtonClicked(_ sender: UIButton) {
        
        self.goBackClicked?()
    }
    @IBAction func moreButtonClicked(_ sender: UIButton) {
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        height = navigetionBar.frame.maxY
        width = navigetionBar.frame.maxX
    }
}
