//
//  MyConcernCell.swift
//  News
//
//  Created by 经纬泰和 on 2018/12/3.
//  Copyright © 2018 经纬泰和. All rights reserved.
//

import UIKit
import Kingfisher

class MyConcernCell: UICollectionViewCell ,RegisterCellOrNib{
    
    //头像
    @IBOutlet weak var avatarImageView: UIImageView!
    //会员标识
    @IBOutlet weak var vipImageView: UIImageView!
    //用户名
    @IBOutlet weak var nameLabel: UILabel!
    //新的消息通知
    @IBOutlet weak var tipsButton: UIButton!
    var myConcern :MyConcern? {
        didSet{
            self.setNeedsLayout()
        }
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatarImageView.kf.setImage(with: URL(string: (myConcern?.icon)!))
        nameLabel.text = myConcern?.name
        if (myConcern?.is_verify) != nil {
            vipImageView.isHidden = false
        }else {
            vipImageView.isHidden = true
        }
        
        if (myConcern?.tips) != nil {
            tipsButton.isHidden = false
        }else {
            tipsButton.isHidden = true
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tipsButton.layer.borderColor = UIColor.white.cgColor
        tipsButton.layer.borderWidth = 1
    }

}
