//
//  NetworkTool.swift
//  News
//
//  Created by 经纬泰和 on 2018/11/26.
//  Copyright © 2018 经纬泰和. All rights reserved.
//

import Foundation

protocol NetworkToolProtocol {
    //--------------------------------mine 我的---------------------------------
    //我的界面cell数据
    static func loadMyCellData()
    //我的关注数据
    static func loadMyConcern()
}

extension NetworkToolProtocol {
    //--------------------------------mine 我的---------------------------------
    //我的界面cell数据
    static func loadMyCellData(){   
        
    }
    //我的关注数据
    static func loadMyConcern(){
        
    }
}

struct NetworkTool: NetworkToolProtocol {
    
}

