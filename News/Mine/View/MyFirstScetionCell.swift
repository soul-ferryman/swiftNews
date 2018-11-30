//
//  MyFirstScetionCell.swift
//  News
//
//  Created by 经纬泰和 on 2018/11/30.
//  Copyright © 2018 经纬泰和. All rights reserved.
//

import UIKit

class MyFirstScetionCell: UITableViewCell ,RegisterCellOrNib {
    
    //标题
    @IBOutlet weak var leftLabel: UILabel!
    //副标题
    @IBOutlet weak var rightLabel: UILabel!
    //右边箭头
    @IBOutlet weak var rightImageview: UIImageView!

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
