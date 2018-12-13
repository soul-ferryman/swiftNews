//
//  NetworkTool.swift
//  News
//
//  Created by 经纬泰和 on 2018/11/26.
//  Copyright © 2018 经纬泰和. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol NetworkToolProtocol {
    
    //--------------------------------home 首页---------------------------------
//    //首页顶部新闻标题数据数据
    static func loadHomeNewsTitleData(completionHandler:@escaping (_ newsTitles:[HomeNewsTitle])->())
    
    //--------------------------------mine 我的---------------------------------
    //我的界面cell数据
    static func loadMyCellData(completionHandler:@escaping (_ sections:[[MyCellModel]])->())
    //我的关注数据
    static func loadMyConcern(completionHandler:@escaping (_ concerns:[MyConcern])->())
    
}

extension NetworkToolProtocol {
    //--------------------------------home 首页---------------------------------
    //    //首页顶部新闻标题数据数据
    static func loadHomeNewsTitleData(completionHandler:@escaping (_ newsTitles:[HomeNewsTitle])->()) {
        
        let url = BASE_URL + "/article/category/get_subscribed/v1/?"
        let params = [
                        "device_id":device_id,
                        "iid":IID
                      ]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else{
                //网络错误
                return
            }
            
            if let value = response.result.value {
                
                let jsonValue = JSON(value)
                if let data = jsonValue["data"].dictionary {
                    if let datas = data["data"]?.arrayObject {
                        var newsTitles = [HomeNewsTitle]()
                        let jsonString = "{\"category\":\"\",\"name\":\"推荐\"}"
                        let recommend = HomeNewsTitle.deserialize(from: jsonString)
                        newsTitles.append(recommend!)
                        
                        
                        for item in datas {
                           
                            let homeNewsTitle = HomeNewsTitle.deserialize(from: item as? NSDictionary)
                            newsTitles.append(homeNewsTitle!)
                        }
                        
                        completionHandler(newsTitles)
                    }
                    
                }
                
            }
            
            
            
        }
        
        
    }
    
    
    
    
    
    
    
    
    //--------------------------------mine 我的---------------------------------
    //我的界面cell数据
    static func loadMyCellData(completionHandler:@escaping (_ sections:[[MyCellModel]])->()){
        
        let url = BASE_URL + "/user/tab/tabs/?"
        let params  = ["device_id":device_id]
        
        Alamofire.request(url,parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                //网络错误
                return
            }
            
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else {
                    return
                }
                if let data = json["data"].dictionary {
                    print(data)
                    if let sections = data["sections"]?.array {
                        var sectionArray = [[MyCellModel]]()
                        for item in sections {
                            var rows = [MyCellModel]()
                            for row in item.arrayObject! {
                                let myCellModel = MyCellModel.deserialize(from: row as? NSDictionary)
                                rows.append(myCellModel!)
                            }
                            sectionArray.append(rows)
                        }
                        
                        completionHandler(sectionArray)
                    }
                }
            }
        }
    }
    //我的关注数据
    static func loadMyConcern(completionHandler:@escaping (_ concerns:[MyConcern])->()){
        
        let url = BASE_URL + "/concern/v2/follow/my_follow/??"
        let params  = ["device_id":device_id]
        
        Alamofire.request(url,parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                //网络错误
                return
            }
            
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else {
                    return
                }
                if let datas = json["data"].arrayObject {
                    print(datas)
                    var concernsArray = [MyConcern]()
                    
                    for data in datas {
                        
                        let myConcrenModel = MyConcern.deserialize(from: data as? NSDictionary)
                        concernsArray.append(myConcrenModel!)
                        
                    }
                    
                    completionHandler(concernsArray)
                   
                }
               
            }
           
        }
        
    }
    
}

struct NetworkTool: NetworkToolProtocol {
    
}

