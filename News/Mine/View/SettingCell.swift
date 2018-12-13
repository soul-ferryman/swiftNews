//
//  SettingCell.swift
//  News
//
//  Created by 经纬泰和 on 2018/12/10.
//  Copyright © 2018 经纬泰和. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell,RegisterCellOrNib {
    
    var settingModel:SettingModel? {
        didSet {
            titleLabel.text = settingModel!.title
            subTitleLabel.text = settingModel!.subTitle
            rightTitleLabel.text = settingModel!.rightTitle
            arrowImageView.isHidden = settingModel!.isHiddenRightArraw
            switchView.isHidden = settingModel!.isHiddenSwitch
            
            if settingModel!.isHiddenSubTitleTitle {
                subTitleHeight.constant = 20
                layoutIfNeeded()
            }
        }
    }
    

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var rightTitleLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var switchView: UISwitch!
    @IBOutlet weak var bottomLine: UIView!
    
    @IBOutlet weak var subTitleHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        theme_backgroundColor = "colors.cellBackfroundColor"
        
        titleLabel.theme_textColor = "colors.black"
        
        rightTitleLabel.theme_textColor = "colors.cellRightTextColor"
        
        arrowImageView.theme_image = "images.cellRightArrow"
        
        bottomLine.theme_backgroundColor = "colors.separatorViewColor"
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
