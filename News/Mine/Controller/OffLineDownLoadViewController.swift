//
//  OffLineDownLoadViewController.swift
//  News
//
//  Created by 经纬泰和 on 2018/12/13.
//  Copyright © 2018 经纬泰和. All rights reserved.
//

import UIKit

class OffLineDownLoadViewController: UITableViewController {
    
    var dataArray = [HomeNewsTitle]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        NetworkTool.loadHomeNewsTitleData { (homeNewsTitles) in
            self.dataArray = homeNewsTitles
            self.tableView.reloadData()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 44))
        view.theme_backgroundColor = "colors.viewBackgroundColors"
        let label = UILabel.init(frame: CGRect(x: 15, y: 0, width: ScreenWidth-15, height: 44))
        label.text = "我的频道"
        label.theme_textColor = "colors.black"
        
        let separatorView = UIView(frame: CGRect(x: 0, y: 43, width: ScreenWidth, height: 1))
        separatorView.theme_backgroundColor = "colors.separatorViewColor"
        
        
        view.addSubview(label)
        view.addSubview(separatorView)
        return view
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.lwn_dequeueReusableCell(indexPath: indexPath) as OffLineDownLoadCell
        cell.homeNewsTitle = self.dataArray[indexPath.row]
        return cell
        
    }

    

}

extension OffLineDownLoadViewController {
    func setupUI(){
        tableView.lwn_registerCell(cell: OffLineDownLoadCell.self)
        tableView.rowHeight = 44
        tableView.showsVerticalScrollIndicator = false
        tableView.theme_separatorColor = "colors.separatorViewColor"
        tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        tableView.theme_backgroundColor = "colors.viewBackgroundColors"
        
        let downloadButton = UIButton(type: .custom)
        downloadButton.setTitle("下载", for: .normal)
        downloadButton.sizeToFit()
        downloadButton.addTarget(self, action: #selector(downloadButtonClicked), for: .touchUpInside)
        
        let rightBarButtonItem = UIBarButtonItem.init(customView: downloadButton)
        self.navigationController?.navigationItem.rightBarButtonItem = rightBarButtonItem
        
    }
    
    @objc func downloadButtonClicked() {
        print("点击了下载")
    }
}
