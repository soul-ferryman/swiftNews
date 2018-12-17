//
//  UserDetail.swift
//  News
//
//  Created by 经纬泰和 on 2018/12/17.
//  Copyright © 2018 经纬泰和. All rights reserved.
//

import Foundation
import HandyJSON

//用户详情模型
struct UserDetail:HandyJSON {
    var screen_name :String = ""
    var name:String = ""
    var big_avatar_url:String = ""
    var avatar_url:String = ""
    var status:Int = 0
    var is_followed:Bool = false
    var is_following:Bool = false
    var current_user_id:Int = 0
    var media_id:Int = 0
    var ugc_publish_media_id:Int = 0
    var user_id:Int = 0
    var creator_id:Int = 0
    var description:String = ""
    var descriptionHeight:CGFloat? {
        return description.boundingRect(with: CGSize(width: ScreenWidth-30.0, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: 13)], context: nil).size.height + 5.0
    }
    var apply_auth_url: String = ""
    var bottom_tab:[BottomTab] = [BottomTab]()
    var top_tab:[TopTab] = [TopTab]()
    var bg_img_url: String = ""
    
    var verified_content: String = ""
    var user_verified: Bool = false
    
    var verified_agency: String = "" // 头条认证
    
    var is_blocking: Bool = false
    var is_blocked: Bool = false
    
    var gender: Int = 0
    
    var share_url: String = ""
    
    var followers_count: Int = 0// 粉丝 470837
    
    var followersCount:String?{
        guard followers_count >= 10000 else {
            return String(describing: followers_count)
        }
        
        return String(format: "%.1f万", Float(followers_count)/10000.0)
    }
    
    var followings_count: Int = 0// 粉丝 470837
    
    var followingsCount:String?{
        guard followers_count >= 10000 else {
            return String(describing: followers_count)
        }
        
        return String(format: "%.1f万", Float(followers_count)/10000.0)
    }
    
    var media_type: Int = 0
    
    var area: String = ""
    
    var user_auth_info:String = ""
    
    var userAuthInfo:UserAuthInfo?{
        return UserAuthInfo.deserialize(from: user_auth_info)
    }
    
}

struct BottomTab:HandyJSON {
    var type:String = ""
    var name:String = ""
    var value:String = ""
    var children:[BottomTabChildren] = [BottomTabChildren]()
    
}

struct BottomTabChildren:HandyJSON {
    var schema_href: String = "" // sslocal://webview?url=http%3A%2F%2Fwww.guanfumuseum.org.cn%2F
    
    var type: String = "" // href
    
    var name: String = ""
    
    var value: String = "" // http://www.guanfumuseum.org.cn/
}

struct TopTab:HandyJSON {
    var url: String = ""
    
    var is_default: Bool = false
    
    var show_name: String = "" // 动态 文章 视频 问答
    
    var type:String = ""
    
}

// MARK: 关注用户
struct ConcernUser: HandyJSON {
    
    var is_followed: Bool = false
    var is_following: Bool = false // 是否正在关注
    
    var media_id: Int = 0               // 1554769814257666
    
    var create_time: TimeInterval = 0
    
    var user_verified: Bool = false
    
    var screen_name: String = "" // 考研张雪峰
    var name: String = "" // 考研张雪峰
    
    var user_id: Int = 0                // 53271122458
    
    var last_update: String = ""
    
    var avatar_url: String = ""
    
    var user_auth_info:String = ""
    
    var userAuthInfo:UserAuthInfo?{
        return UserAuthInfo.deserialize(from: user_auth_info)
    }
    
    var type: Int = 0
}


struct UserCard:HandyJSON {
    var name:String = ""
    var recommend_reason:String = ""
    var recommend_type:Int = 0
    var stats_place_holder: String = ""
    var user:UserCardUser = UserCardUser()
    
}

struct UserCardUser:HandyJSON {
    
    var info:UserCardUserInfo = UserCardUserInfo()
    
    var relation: UserCardUserRelation = UserCardUserRelation()

}

struct UserCardUserInfo:HandyJSON {
    var name: String = ""
    
    var user_id: Int = 0
    
    var avatar_url: String = ""
    
    var desc: String = ""
    
    var schema: String = ""
    
    var user_auth_info:String = ""
    
    var userAuthInfo:UserAuthInfo?{
        return UserAuthInfo.deserialize(from: user_auth_info)
    }
}

struct UserCardUserRelation:HandyJSON {
    var is_followed: Bool = false
    
    var is_following: Bool = false
    
    var is_friend: Bool = false
    
}

