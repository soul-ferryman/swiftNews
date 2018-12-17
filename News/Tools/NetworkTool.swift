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
import SVProgressHUD

protocol NetworkToolProtocol {
    
    //--------------------------------home 首页---------------------------------
//    //首页顶部新闻标题数据数据
    static func loadHomeNewsTitleData(completionHandler:@escaping (_ newsTitles:[HomeNewsTitle])->())
    
    //--------------------------------mine 我的---------------------------------
    //我的界面cell数据
    static func loadMyCellData(completionHandler:@escaping (_ sections:[[MyCellModel]])->())
    //我的关注数据
    static func loadMyConcern(completionHandler:@escaping (_ concerns:[MyConcern])->())
    
    ///获取用户详情数据
    static func loadUserDetail(user_id:Int,completionHandler:@escaping (_ userDetailData:UserDetail)->())
    
    ///已关注用户，取消关注
    static func loadRelationUnfollow(user_id:Int,completionHandler:@escaping (_ user:ConcernUser)->())
    
    ///点击关注按钮，关注用户
    static func loadRelationFollow(user_id:Int,completionHandler:@escaping (_ user:ConcernUser)->())
    
    ///点击了关注按钮，就会出现相关推荐数据
    static func loadRelationUserRecommend(user_id:Int, completionHandler:@escaping (_ userCard:[UserCard])->())
    
}

extension NetworkToolProtocol {
    //--------------------------------home 首页---------------------------------
    ///首页顶部新闻标题数据数据
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
    ///我的界面cell数据
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
    ///我的关注数据
    static func loadMyConcern(completionHandler:@escaping (_ concerns:[MyConcern])->()){
        
        let url = BASE_URL + "/concern/v2/follow/my_follow/?"
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
                    
                    
//                    completionHandler(datas.flatMap({
//                        MyConcern.deserialize(from: $0 as? NSDictionary)
//                    }))
                    
                    completionHandler(concernsArray)
                   
                }
               
            }
           
        }
        
    }
    
    
    ///获取用户详情数据
    static func loadUserDetail(user_id:Int,completionHandler:@escaping (_ userDetailData:UserDetail)->()){
        
        let url = BASE_URL + "/user/profile/homepage/v4/?"
        let params  = ["device_id":device_id,
                       "user_id" :user_id,
                       "iid": IID
                       ]
        
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
                if let data = json["data"].dictionaryObject {
                    let userDetailModel = UserDetail.deserialize(from: data as NSDictionary)
                    completionHandler(userDetailModel!)
                    }
                }
            }
        }
    
    
    
    ///已关注用户，取消关注
    static func loadRelationUnfollow(user_id:Int,completionHandler:@escaping (_ user:ConcernUser)->()){
        
        let url = BASE_URL + "/2/relation/unfollow/?"
        let params  = ["device_id":device_id,
                       "user_id" :user_id,
                       "iid": IID
        ]
        
        Alamofire.request(url,parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                //网络错误
                return
            }
            
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else {
                    
                    if let data = json["data"].dictionaryObject {
                        SVProgressHUD.showInfo(withStatus: data["description"] as? String)
                        SVProgressHUD.setForegroundColor(UIColor.white)
                        SVProgressHUD.setBackgroundColor(UIColor.init(rgbValueFromHex: 0xf5f5f5))
                    }
                    
                    return
                }
                if let data = json["data"].dictionaryObject {
                    let userDetailModel = ConcernUser.deserialize(from: data["user"] as? NSDictionary)
                    completionHandler(userDetailModel!)
                }
            }
        }
    }
    
    
    ///点击关注按钮，关注用户
    static func loadRelationFollow(user_id:Int,completionHandler:@escaping (_ user:ConcernUser)->()){
        
        let url = BASE_URL + "/2/relation/follow/v2/?"
        let params  = ["device_id":device_id,
                       "user_id" :user_id,
                       "iid": IID
        ]
        
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
                if let data = json["data"].dictionaryObject {
                    let userDetailModel = ConcernUser.deserialize(from: data["user"] as? NSDictionary)
                    completionHandler(userDetailModel!)
                }
            }
        }
    }
    
    
    ///点击了关注按钮，就会出现相关推荐数据
    static func loadRelationUserRecommend(user_id:Int, completionHandler:@escaping (_ userCard:[UserCard])->()){
        
        let url = BASE_URL + "/user/relation/user_recommend/v1/supplement_recommends/?"
        let params = ["device_id": device_id,
                      "follow_user_id": user_id,
                      "iid": IID,
                      "scene": "follow",
                      "source": "follow"] as [String : Any]
        
        Alamofire.request(url,parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                //网络错误
                return
            }
            
            if let value = response.result.value {
                let json = JSON(value)
                guard json["err_no"] == 0 else {
                    return
                }
                if let user_cards = json["user_cards"].arrayObject {
                    var userCardsArray = [UserCard]()
                    
                    for data in user_cards {
                        
                        let userCardModel = UserCard.deserialize(from: data as? NSDictionary)
                        userCardsArray.append(userCardModel!)
                        
                    }
                    completionHandler(userCardsArray)
                    
                }
                
            }
            
        }
        
    }
    
}

struct NetworkTool: NetworkToolProtocol {
    
}

