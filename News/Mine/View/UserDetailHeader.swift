//
//  UserDetailHeader.swift
//  News
//
//  Created by 经纬泰和 on 2018/12/17.
//  Copyright © 2018 经纬泰和. All rights reserved.
//

import UIKit
import IBAnimatable
import Kingfisher

class UserDetailHeader: UIView {
    
    
    var userDetail:UserDetail? {
        didSet{
            
            backgroundImageView.kf.setImage(with: URL(string: userDetail!.bg_img_url))
            avatarImageView.kf.setImage(with: URL(string: userDetail!.avatar_url))
            vImageView.isHighlighted = userDetail!.user_verified
            nameLabel.text = userDetail!.screen_name
            if userDetail!.verified_agency == "" {
                vweifiedAgencyLabelHeight.constant = 0
                verifiedAgencyLabelTop.constant = 0
            }else {
                verifiedAgencyLabel.text = userDetail!.verified_agency + "："
                verifiedContentLabel.text = userDetail!.verified_content
            }
            
            concernButton.isSelected = userDetail!.is_following
            concernButton.theme_backgroundColor = userDetail!.is_following ? "colors.userDetailFollowingConcernBtnBgColor" : "colors.globalRedColor"
            concernButton.borderColor = userDetail!.is_following ? .grayColor232() : .globalRedColor()
            concernButton.borderWidth = userDetail!.is_following ? 1 : 0
            if userDetail!.area == "" {
                areaButton.isHidden = true
                areaButtonHeight.constant = 0
                areaButtonTop.constant = 0
            }else {
                areaButton.setTitle(userDetail!.area, for: .normal)
            }
            
            descriptionLabel.text = userDetail!.description
            
            if userDetail!.descriptionHeight! > 21 {
                unfoldButton.isHidden = false
                unfoldButtonWidth.constant = 40.0
            }
            
            recommendButtonWidth.constant = 0
            recommendButtonTrailing.constant = 10.0
            
            
            followersCountContentLabel.text = userDetail!.followingsCount
            
            followingsCountLabel.text = userDetail!.followersCount
            
            
            
            layoutIfNeeded()
            
        }
    }
    

    //背景图片
    @IBOutlet weak var backgroundImageView: UIImageView!
    //背景图片顶部约束
    @IBOutlet weak var bgImageViewTop: NSLayoutConstraint!
    //用户头像
    @IBOutlet weak var avatarImageView: AnimatableImageView!
    //v 图标
    @IBOutlet weak var vImageView: UIImageView!
    //用户名
    @IBOutlet weak var nameLabel: UILabel!
    //头条号图标
    @IBOutlet weak var toutiaohaoImageView: UIImageView!
    //发私信按钮
    @IBOutlet weak var sendMailButton: UIButton!
    //关注按钮
    @IBOutlet weak var concernButton: AnimatableButton!
    //推荐按钮
    @IBOutlet weak var recommendButton: AnimatableButton!
    @IBOutlet weak var recommendButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var recommendButtonTrailing: NSLayoutConstraint!
    //推荐view
    @IBOutlet weak var recommendView: UIView!
    @IBOutlet weak var recommendViewHeight: NSLayoutConstraint!
    //头条认证
    @IBOutlet weak var verifiedAgencyLabel: UILabel!
    @IBOutlet weak var vweifiedAgencyLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var verifiedAgencyLabelTop: NSLayoutConstraint!
    //认证内容
    @IBOutlet weak var verifiedContentLabel: UILabel!
    //地区
    @IBOutlet weak var areaButton: UIButton!
    @IBOutlet weak var areaButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var areaButtonTop: NSLayoutConstraint!
    //描述内容
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionLabelHeight: NSLayoutConstraint!
    //展开按钮
    @IBOutlet weak var unfoldButton: UIButton!
    @IBOutlet weak var unfoldButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var unfoldButtonTrailing: NSLayoutConstraint!
    //关注数量
    @IBOutlet weak var followingsCountLabel: UILabel!
    //粉丝数量
    @IBOutlet weak var followersCountContentLabel: UILabel!
    @IBOutlet weak var followersCountLabel: NSLayoutConstraint!
    //文章 视频 问答
    @IBOutlet weak var topTabView: UIView!
    @IBOutlet weak var topTabHeight: NSLayoutConstraint!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    //底层view
    @IBOutlet weak var baseView: UIView!
    
   
    override func awakeFromNib() {
        //
        
        concernButton.setTitle("关注", for: .normal)
        concernButton.setTitle("已关注", for: .selected)
        
        //设置主题颜色
        theme_backgroundColor = "colors.cellBackfroundColor"
        baseView.theme_backgroundColor = "colors.cellBackfroundColor"
        avatarImageView.layer.theme_borderColor = "colors.cellBackfroundColor"
        topTabView.theme_backgroundColor = "colors.cellBackfroundColor"
        separatorView.theme_backgroundColor = "colors.separatorViewColor"
        nameLabel.theme_textColor = "colors.black"
        sendMailButton.theme_setTitleColor("colors.userDetailSendMailTextColor", forState: .normal)
//        unfoldButton.theme_setTitleColor("colors.userDetailSendMailTextColor", forState: .normal)
        followersCountContentLabel.theme_textColor = "colors.userDetailSendMailTextColor"
        followingsCountLabel.theme_textColor = "colors.userDetailSendMailTextColor"
        concernButton.theme_setTitleColor("colors.userDetailConcernButtonTextColor", forState: .normal)
        concernButton.theme_setTitleColor("colors.userDetailConcernButtonSelectedTextColor", forState: .selected)
        verifiedAgencyLabel.theme_textColor = "colors.verifiedAgencyTextColor"
        verifiedContentLabel.theme_textColor = "colors.black"
        descriptionLabel.theme_textColor = "colors.black"
        descriptionLabel.theme_textColor = "colors.black"
        toutiaohaoImageView.theme_image = "images.toutiaohao"
        
        
    }
    
    //类方法
    class func headerView() -> UserDetailHeader {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.last as! UserDetailHeader
    }
    
    //发私信点击
    @IBAction func sendMailButtonClicked(_ sender: Any) {
    }
    //关注按钮点击
    @IBAction func concernButtonClicked(_ sender: AnimatableButton) {
        
        if sender.isSelected {
            //已经关注，点击取消关注
            NetworkTool.loadRelationUnfollow(user_id: userDetail!.user_id) { (_) in
                sender.isSelected = !sender.isSelected
                self.concernButton.theme_backgroundColor = "colors.globalRedColor"
                self.recommendButton.isHidden = true
                self.recommendButtonWidth.constant = 0
                self.recommendButton.isSelected = false
                self.recommendButtonTrailing.constant = 0
                self.recommendViewHeight.constant = 0
                UIView.animate(withDuration: 0.25, animations: {
                    self.recommendButton.imageView?.transform = .identity
                    self.layoutIfNeeded()
                },completion: { (_) in
                    self.resetLayout()
                })
            }
            
        }else {
            //未关注，点击则关注
            NetworkTool.loadRelationFollow(user_id: userDetail!.user_id) { (_) in
                //
                sender.isSelected = !sender.isSelected
                self.concernButton.theme_backgroundColor =  "colors.userDetailFollowingConcernBtnBgColor"
                self.recommendButton.isHidden = false
                self.recommendButtonWidth.constant = 28
                self.recommendButton.isSelected = true
                self.recommendButtonTrailing.constant = 15.0
                self.recommendViewHeight.constant = 223
                UIView.animate(withDuration: 0.25, animations: {
                    self.layoutIfNeeded()
                },completion: { (_) in
                    self.resetLayout()
                    NetworkTool.loadRelationUserRecommend(user_id: self.userDetail!.user_id, completionHandler: { (userCard) in
                        //
                    })
                })
            }
        }
        
    }
    //推荐关注按钮点击
    @IBAction func recommendButtonClicked(_ sender: AnimatableButton) {
        
        sender.isSelected = !sender.isSelected
        
        recommendViewHeight.constant = sender.isSelected ? 223.0 : 0
        
        UIView.animate(withDuration: 0.25, animations: {
            sender.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat(sender.isSelected ? 0 :Double.pi))
            self.layoutIfNeeded()
        }) { (_) in
            self.resetLayout()
        }
        
    }
    //展开按钮
    @IBAction func unfoldButtonClicked(_ sender: Any) {
        
        unfoldButton.isHidden = true
        unfoldButtonWidth.constant = 0;
        
        descriptionLabelHeight.constant = userDetail!.descriptionHeight!
        
        UIView.animate(withDuration: 0.25, animations: {
            self.layoutIfNeeded()
        }) { (_) in
            self.resetLayout()
        }
        
    }
    
    func resetLayout(){
        baseView.height = topTabView.frame.maxY
        height = baseView.frame.maxY
    }
    
}
