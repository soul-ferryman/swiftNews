//
//  SQLiteManager.swift
//  News
//
//  Created by 经纬泰和 on 2018/12/14.
//  Copyright © 2018 经纬泰和. All rights reserved.
//

import Foundation
import Foundation
import SQLite

struct SQLiteManager {
    
    var database:Connection!
    
    init() {
        do {
            //指定路径
            let path = NSHomeDirectory() + "/Documents/news.sqlite3"
            //创建数据库
            database = try Connection(path)
        } catch  {
            //打印异常
            print(error)
        }
    }
    
}

//首页新闻分类的标题数据表
struct NewsTitleTable {
    //数据库管理者
    private let sqlManager = SQLiteManager()
    //新闻标题 表
    private let news_title = Table("news_title")
    //表字段
    let id = Expression<Int64>("id")
    let category = Expression<String>("category")
    let tip_new = Expression<Int64>("tip_new")
    let default_add = Expression<Int64>("default_add")
    let web_url = Expression<String>("web_url")
    let concern_id = Expression<String>("concern_id")
    let icon_url = Expression<String>("icon_url")
    let flags = Expression<Int64>("flags")
    let type = Expression<Int64>("type")
    let name = Expression<String>("name")
    let selected = Expression<Bool>("selected")
    
    
    init() {
        do {
            //建表
            try sqlManager.database.run(news_title.create(ifNotExists:true) { t in
                t.column(id, primaryKey: true)
                t.column(category)
                t.column(tip_new)
                t.column(default_add)
                t.column(web_url)
                t.column(concern_id)
                t.column(icon_url)
                t.column(flags)
                t.column(type)
                t.column(name)
                t.column(selected)
            })
            
        } catch  {
            //打印异常
            print(error)
        }
    }
    
    //插入一组数据
    func insert(_ titles:[HomeNewsTitle]) {
        
        for title in titles {
            insert(title)
        }
        
    }
    //插入一条数据
    func insert(_ title:HomeNewsTitle) {
        //如果数据库中该条数据不存在，就插入
        if !exist(title) {
            let insertData = news_title.insert(
                category <- title.category,
                tip_new <- Int64(title.tip_new),
                default_add <- Int64(title.default_add),
                web_url <- title.web_url,
                concern_id <- title.concern_id,
                icon_url <- title.icon_url,
                flags <- Int64(title.flags),
                type <- Int64(title.type),
                name <- title.name,
                selected <- Bool(title.selected)
            )
            
            do {
                //插入数据
                try sqlManager.database.run(insertData)
            } catch {
                print(error)
            }
            
        }else {//如果数据库中该条数据存在，就不插入
            
        }
    }
    
    //判断数据库中某一条数据是否存在
    func exist(_ title:HomeNewsTitle) -> Bool {
        //取出该新闻分类标题的数据
        let title = news_title.filter(category == title.category)
        do {
            //判断该条数据是否存在，因为没有直接的方法判断，所以可以根据count是否是0来判断是否存在 0表示没有该条数据 1表示存在
            let count = try sqlManager.database.scalar(title.count)
            
            return count != 0
            
        }catch {
            print(error)
        }
        
        return false
    }
    
    //查询所有数据
    func selectAll() -> [HomeNewsTitle] {
        var allTitles = [HomeNewsTitle]()
        
        do {
            for title in try sqlManager.database.prepare(news_title) {
                //取出表中数据，并初始化为一个结构体模型
                let newsTitle = HomeNewsTitle(category: title[category], web_url: title[web_url], flags: Int(title[flags]), name: title[name], tip_new: Int(title[tip_new]), default_add: Int(title[default_add]), concern_id: title[concern_id], type: Int(title[type]), icon_url: title[icon_url], selected: title[selected])
                
                
                //添加到数组中
                allTitles.append(newsTitle)
            }
            
            return allTitles
            
        } catch  {
            print(error)
        }
        return []
    }
    
    //更新数据
    func update(_ newstitle:HomeNewsTitle) {
        do {
            //取出数据库中的数据
            let title = news_title.filter(category == newstitle.category)
            try sqlManager.database.run(title.update(selected <- newstitle.selected))
        } catch  {
            print(error)
        }
    }
    
    
}
