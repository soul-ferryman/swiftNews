//
//  SettingModel.swift
//  News
//
//  Created by 经纬泰和 on 2018/12/10.
//  Copyright © 2018 经纬泰和. All rights reserved.
//

import Foundation
import HandyJSON

struct SettingModel: HandyJSON {

    var title = ""
    var rightTitle = ""
    var subTitle = ""
    var isHiddenSubTitleTitle:Bool = false
    var isHiddenRightTitle:Bool = false
    var isHiddenSwitch:Bool  = false
    var isHiddenRightArraw:Bool = false
    
    
}
