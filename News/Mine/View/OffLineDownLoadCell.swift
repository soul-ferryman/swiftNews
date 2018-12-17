//
//  OffLineDownLoadCell.swift
//  News
//
//  Created by 经纬泰和 on 2018/12/13.
//  Copyright © 2018 经纬泰和. All rights reserved.
//

import UIKit

class OffLineDownLoadCell: UITableViewCell,RegisterCellOrNib {
    
    var homeNewsTitle: HomeNewsTitle? {
        didSet{
            titleLabel.text = homeNewsTitle?.name
            rightImageView.theme_image = (homeNewsTitle?.selected)! ? "images.air_download_option_press" : "images.air_download_option"
        }
    }
    

    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        theme_backgroundColor = "colors.cellBackfroundColor"
        rightImageView.theme_image = "images.air_download_option_press"
        titleLabel.theme_textColor = "colors.black"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
