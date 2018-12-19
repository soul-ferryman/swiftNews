//
//  MineViewController.swift
//  News
//
//  Created by 经纬泰和 on 2018/11/13.
//  Copyright © 2018 经纬泰和. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class MineViewController: UITableViewController {
    
    
    var sections = [[MyCellModel]]()
    var concerns = [MyConcern]()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var headerView = MyHeaderView.headerView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        tableView.tableFooterView = UIView()
        tableView.theme_backgroundColor = "colors.viewBackgroundColors"
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: String(describing: MyOtherCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MyOtherCell.self))
        tableView.register(UINib(nibName: String(describing: MyFirstScetionCell.self),bundle: nil), forCellReuseIdentifier: String(describing: MyFirstScetionCell.self))
        tableView.lwn_registerCell(cell: MyFirstScetionCell.self)
        tableView.lwn_registerCell(cell: MyOtherCell.self)
        tableView.tableHeaderView = headerView
        

        
        //获取我的cell数据
        NetworkTool.loadMyCellData { (sections) in
            let string = "{\"text\":\"我的关注\",\"grey_text\":\"\"}"
            let myConcern = MyCellModel.deserialize(from: string)
            var myConcerns = [MyCellModel]()
            myConcerns.append(myConcern!)
            self.sections.append(myConcerns)
            self.sections += sections;
            self.tableView.reloadData()
            
            NetworkTool.loadMyConcern(completionHandler: { (concerns) in
                self.concerns = concerns
                let indexSet = NSIndexSet(index: 0)
                self.tableView.reloadSections(indexSet as IndexSet, with: .automatic)
            })
        }
        
        headerView.moreLoginButton.rx.controlEvent(.touchUpInside) .subscribe(onNext: { [weak self] in
            
            let storyboard = UIStoryboard(name: String(describing: MoreLoginViewController.self), bundle: nil)
            let moreLoginVC = storyboard.instantiateViewController(withIdentifier: String(describing: MoreLoginViewController.self)) as! MoreLoginViewController
            moreLoginVC.modalSize = (width: .full , height: .custom(size:Float(ScreenHeight - ( isIPhoneX ? 44: 20 ))))
            self!.present(moreLoginVC, animated: true, completion: nil)
            
        })
        
        
    }
    

}


extension MineViewController{
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 0:10
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0  {
            return (concerns.count == 0 || concerns.count == 1) ? 40 : 114
        }
        
        return 40
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 10)) 
        view.theme_backgroundColor = "colors.viewBackgroundColors"
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
            cell.myCellModel = section[indexPath.row]

            if concerns.count == 0 || concerns.count == 1 {
                cell.collectionView.isHidden = true
            }
            if concerns.count == 1 {
                cell.myConcern = concerns[0]
            }
            
            if concerns.count > 1{
                cell.myConcerns = concerns
            }
            
            cell.delegate = self
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
        
        let model = sections[indexPath.section][indexPath.row]
        
        
        if model.text == "系统设置" {
            let settingVC = SettingViewController.init(style: .grouped)
            settingVC.title = "设置"
            self.navigationController?.pushViewController(settingVC, animated: true);
        }
        
        
    }
    
    
}

extension MineViewController:MyFirstScetionCellDelegate {
    //点击了第几个cell
    func MyFirstSectionCell(_ firstCell: MyFirstScetionCell, myConcern:MyConcern) {
        
        let userDetailVC = UserDetailViewController()
        
        userDetailVC.userId = myConcern.userid ?? 0
        
        self.navigationController?.pushViewController(userDetailVC, animated: true)
        
    }
}

