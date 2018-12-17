//
//  HomeViewController.swift
//  News
//
//  Created by 经纬泰和 on 2018/11/13.
//  Copyright © 2018 经纬泰和. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    //标题数据表
    fileprivate let newsTitleTable = NewsTitleTable()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.white
        
       
        
        NetworkTool.loadHomeNewsTitleData { (homeNewsTitles) in
            //向数据库中插入数据
            self.newsTitleTable.insert(homeNewsTitles)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
