//
//  MineViewController.swift
//  News
//
//  Created by 经纬泰和 on 2018/11/13.
//  Copyright © 2018 经纬泰和. All rights reserved.
//

import UIKit


class MineViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.globalBackgroundColor()

        
        //获取我的cell数据
        NetworkTool.loadMyCellData()
    }
    

}


extension MineViewController{
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 10)) 
        view.backgroundColor = UIColor.globalBackgroundColor()
        return view
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}

