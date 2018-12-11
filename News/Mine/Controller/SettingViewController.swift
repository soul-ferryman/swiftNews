//
//  SettingViewController.swift
//  News
//
//  Created by 经纬泰和 on 2018/12/10.
//  Copyright © 2018 经纬泰和. All rights reserved.
//

import UIKit

class SettingViewController: UITableViewController {
    
    //存储plist文件中的数据
    var sections = [[SettingModel]]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 10))
        view.theme_backgroundColor = "colors.viewBackgroundColors"
        return view
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rows = sections[indexPath.section]
        let settingModel = rows[indexPath.row]
        if settingModel.title == "推送通知" {
            return 64
        }else {
            return 44
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = sections[section]
        
        return rows.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.lwn_dequeueReusableCell(indexPath: indexPath) as SettingCell
        
        let rows = sections[indexPath.section]
        let settingModel = rows[indexPath.row]
        cell.settingModel = settingModel
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }


    
}


extension SettingViewController {
    
    private func setupUI() {
        //plist文件路径
        let path = Bundle.main.path(forResource: "settingPlist", ofType: "plist")
        //plist文件数据
        let cellPlist = NSArray(contentsOfFile: path!) as! [Any]
        for dicts in cellPlist {
            let array = dicts as! [[String:Any]]
            var rows = [SettingModel]()
            for dict in array {
                let setting = SettingModel.deserialize(from: dict as NSDictionary)
                rows.append(setting!)
            }
            sections.append(rows)
        }
        
        
        
        tableView.lwn_registerCell(cell: SettingCell.self)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        tableView.theme_backgroundColor = "colors.viewBackgroundColors"
        
    }
    
}
