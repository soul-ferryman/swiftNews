//
//  UserDetailHeader.swift
//  News
//
//  Created by 经纬泰和 on 2018/12/17.
//  Copyright © 2018 经纬泰和. All rights reserved.
//

import UIKit
import IBAnimatable

class UserDetailHeader: UIView {
    
    
    var userDetail:UserDetail? {
        didSet{
            
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
    }
    
    //类方法
    class func headerView() -> UserDetailHeader {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.last as! UserDetailHeader
    }
    
    
    
    
}
