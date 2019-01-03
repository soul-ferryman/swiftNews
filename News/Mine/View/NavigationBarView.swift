//
//  NavigationBarView.swift
//  News
//
//  Created by 经纬泰和 on 2019/1/3.
//  Copyright © 2019 经纬泰和. All rights reserved.
//

import UIKit

class NavigationBarView: UIView , NibLoadable{

    @IBOutlet weak var statusBarView: UIView!
    @IBOutlet weak var navigetionBar: UIView!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        returnButton.theme_setImage("images.personal_home_back_white_24x24_", forState: .normal)
        moreButton.theme_setImage("images.new_morewhite_titlebar_22x22_", forState: .normal)
    }

    @IBAction func returnButtonClicked(_ sender: UIButton) {
    }
    @IBAction func moreButtonClicked(_ sender: UIButton) {
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        height = navigetionBar.frame.maxY
        width = navigetionBar.frame.maxX
    }
}
