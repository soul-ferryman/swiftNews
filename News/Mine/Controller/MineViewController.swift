//
//  MineViewController.swift
//  News
//
//  Created by 经纬泰和 on 2018/11/13.
//  Copyright © 2018 经纬泰和. All rights reserved.
//

import UIKit


class MineViewController: UITableViewController {
    
    var sections = [[MyCellModel]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.globalBackgroundColor()
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: String(describing: MyOtherCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MyOtherCell.self))
        tableView.register(UINib(nibName: String(describing: MyFirstScetionCell.self),bundle: nil), forCellReuseIdentifier: String(describing: MyFirstScetionCell.self))
        tableView.lwn_registerCell(cell: MyFirstScetionCell.self)
        tableView.lwn_registerCell(cell: MyOtherCell.self)
        

        
        //获取我的cell数据
        NetworkTool.loadMyCellData { (sections) in
            let string = "{\"text\":\"我的关注\",\"grey_text\":\"\"}"
            let myConcern = MyCellModel.deserialize(from: string)
            var myConcerns = [MyCellModel]()
            myConcerns.append(myConcern!)
            self.sections.append(myConcerns)
            self.sections += sections;
            
            self.tableView.reloadData()
        }
    }
    

}


extension MineViewController{
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 0:10
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 10)) 
        view.backgroundColor = UIColor.globalBackgroundColor()
        return view
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = tableView.lwn_dequeueReusableCell(indexPath: indexPath) as MyFirstScetionCell
            let section = sections[indexPath.section]
            let myCellModel = section[indexPath.row]
            cell.leftLabel.text = myCellModel.text
            cell.rightLabel.text = myCellModel.grey_text
            return cell
            
        }
        let cell = tableView.lwn_dequeueReusableCell(indexPath: indexPath) as MyOtherCell
        let section = sections[indexPath.section]
        let myCellModel = section[indexPath.row]
        cell.leftLabel.text = myCellModel.text
        cell.rightLabel.text = myCellModel.grey_text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

