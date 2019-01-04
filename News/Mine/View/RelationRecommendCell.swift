//
//  RelationRecommendCell.swift
//  News
//
//  Created by 经纬泰和 on 2019/1/4.
//  Copyright © 2019 经纬泰和. All rights reserved.
//

import UIKit
import IBAnimatable
import Kingfisher

class RelationRecommendCell: UICollectionViewCell , RegisterCellOrNib{

    @IBOutlet weak var avatarImageView: AnimatableImageView!
    @IBOutlet weak var vImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var recommendReasonLabel: UILabel!
    @IBOutlet weak var loadingImageView: UIImageView!
    @IBOutlet weak var concernButton: AnimatableButton!
    
    
    var userCard:UserCard? {
        didSet{
            nameLabel.text = userCard?.user.info.name
            avatarImageView.kf.setImage(with: URL(string: (userCard?.user.info.avatar_url)!))
            vImageView.isHidden = (userCard?.user.info.user_auth_info == "") ? true : false
            recommendReasonLabel.text = userCard?.recommend_reason
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        loadingImageView.isHidden = true
        concernButton.theme_setTitleColor("colors.userDetailConcernButtonTextColor", forState: .normal)
        concernButton.theme_setTitleColor("colors.userDetailConcernButtonSelectedTextColor", forState: .selected)
        concernButton.setTitle("关注", for: .normal)
        concernButton.setTitle("已关注", for: .selected)
    }
    
    
    @IBAction func concernButtonClicked(_ sender: AnimatableButton) {
        
        loadingImageView.isHidden = false
        
        loadingImageView.layer.add(animation, forKey: nil)
        
        if sender.isSelected {
            //已经关注，点击取消关注
            NetworkTool.loadRelationUnfollow(user_id: (userCard?.user.info.user_id)!) { (_) in
                sender.isSelected = !sender.isSelected
                
                self.concernButton.theme_backgroundColor = "colors.globalRedColor"
                self.concernButton.borderColor = .globalRedColor()
                self.concernButton.borderWidth =  0
                self.loadingImageView.layer.removeAllAnimations()
                self.loadingImageView.isHidden = true
            }
            
        }else {
            //未关注，点击则关注
            NetworkTool.loadRelationFollow(user_id: (userCard?.user.info.user_id)!) { (_) in
                //
                sender.isSelected = !sender.isSelected
                self.concernButton.borderColor = .grayColor232()
                self.concernButton.borderWidth =  1
                self.concernButton.theme_backgroundColor =  "colors.userDetailFollowingConcernBtnBgColor"
                self.loadingImageView.layer.removeAllAnimations()
                self.loadingImageView.isHidden = true
            }
        }
        
    }
    
    private lazy var animation:CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0.0
        animation.toValue = Double.pi * 2
        animation.duration = 1.5
        animation.autoreverses = false
        animation.repeatCount = MAXFLOAT
        return animation
    }()

}
