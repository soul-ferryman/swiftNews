//
//  SettingViewController.swift
//  News
//
//  Created by 经纬泰和 on 2018/12/10.
//  Copyright © 2018 经纬泰和. All rights reserved.
//

import UIKit
import Kingfisher

class SettingViewController: UITableViewController {
    
    //存储plist文件中的数据
    var sections = [[SettingModel]]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

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
        
        
        switch indexPath.section {
        case 0:
            //
            switch indexPath.row {
            case 0: //清理缓存
                calculateDiskCashSize(cell)
            case 2:
                cell.selectionStyle = .none
          
            default:
                break
            }
        default: break
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! SettingCell
        
        switch indexPath.section {
        case 0:
            //
            switch indexPath.row {
            case 0: //清理缓存
                clearCacheAlertController(cell)
            case 1: //设置字体
                setupFontAlertController(cell)
            case 3://非WiFi
                setupNetWorkAlertController(cell)
            case 4://网络提醒
                setuPalyNoticeAlertController(cell)
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                let offLineVC = OffLineDownLoadViewController.init(style: .grouped)
                offLineVC.title = "离线下载"
                self.navigationController?.pushViewController(offLineVC, animated: true)
            default:break
            }
        default: break
            
        }
    }

}


extension SettingViewController {
    
    fileprivate func setupUI() {
        //plist文件路径
        let path = Bundle.main.path(forResource: "settingPlist", ofType: "plist")
        //plist文件数据
        let cellPlist = NSArray(contentsOfFile: path!) as! [Any]
//        for dicts in cellPlist {
//            let array = dicts as! [[String:Any]]
//            var rows = [SettingModel]()
//            for dict in array {
//                let setting = SettingModel.deserialize(from: dict as NSDictionary)
//                rows.append(setting!)
//            }
//            sections.append(rows)
//        }
        
        sections = cellPlist.compactMap({ section in
            (section as! [Any]).compactMap({row in
                SettingModel.deserialize(from: row as? NSDictionary)
            })
            
        })
        
        tableView.lwn_registerCell(cell: SettingCell.self)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        tableView.theme_backgroundColor = "colors.viewBackgroundColors"
        
    }

}

extension SettingViewController {
    
    //设置网络提醒
    fileprivate func setuPalyNoticeAlertController(_ cell:SettingCell) {
        let alertVC = UIAlertController(title: "非WiFi网络播放提醒", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let everyAction = UIAlertAction(title: "每次提醒", style: .default) { (_) in
            cell.rightTitleLabel.text = "每次提醒"
        }
        let onceAction = UIAlertAction(title: "提醒一次", style: .default) { (_) in
            cell.rightTitleLabel.text = "提醒一次"
        }
        
        alertVC.addAction(cancelAction)
        alertVC.addAction(everyAction)
        alertVC.addAction(onceAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    //设置网络
    fileprivate func setupNetWorkAlertController(_ cell:SettingCell) {
        let alertVC = UIAlertController(title: "设置字体大小", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let bestAction = UIAlertAction(title: "最佳效果(下载大图)", style: .default) { (_) in
            cell.rightTitleLabel.text = "最佳效果(下载大图)"
        }
        let betterAction = UIAlertAction(title: "较省流量(智能下图)", style: .default) { (_) in
           cell.rightTitleLabel.text = "较省流量(智能下图)"
        }
        let leastAction = UIAlertAction(title: "极省流量(智能下图)", style: .default) { (_) in
           cell.rightTitleLabel.text = "极省流量(智能下图)"
        }
        
        alertVC.addAction(cancelAction)
        alertVC.addAction(bestAction)
        alertVC.addAction(betterAction)
        alertVC.addAction(leastAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    
    //设置字体大小
    fileprivate func setupFontAlertController(_ cell:SettingCell) {
        let alertVC = UIAlertController(title: "设置字体大小", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let smallAction = UIAlertAction(title: "小", style: .default) { (_) in
            cell.rightTitleLabel.text = "小"
        }
        let middleAction = UIAlertAction(title: "中", style: .default) { (_) in
            cell.rightTitleLabel.text = "中"
        }
        let bigAction = UIAlertAction(title: "大", style: .default) { (_) in
            cell.rightTitleLabel.text = "大"
        }
        let largeAction = UIAlertAction(title: "特大", style: .default) { (_) in
            cell.rightTitleLabel.text = "特大"
        }
        alertVC.addAction(cancelAction)
        alertVC.addAction(smallAction)
        alertVC.addAction(middleAction)
        alertVC.addAction(bigAction)
        alertVC.addAction(largeAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    //从沙盒中获取缓存数据的大小
    fileprivate func calculateDiskCashSize( _ cell:SettingCell) {
        let cache = KingfisherManager.shared.cache
        cache.calculateDiskCacheSize { (size) in
            //转成M
            let sizeM = Double(size)/1024.0/1024.0
            let sizeString = String(format: "%.2fM", sizeM)
            cell.rightTitleLabel.text = sizeString
        }
        
    }
    
    
    func clearCacheAlertController(_ cell: SettingCell) {
        let alertVC = UIAlertController(title: "确定清理所有缓存？问答草稿、离线下载及图片均会被清除", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .default) { (_) in
            let cache = KingfisherManager.shared.cache
            cache.clearDiskCache()
            cache.clearMemoryCache()
            cache.cleanExpiredDiskCache()
            cell.rightTitleLabel.text = "0.00M"
            
        }
        alertVC.addAction(cancelAction)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
        
    }
    
}

