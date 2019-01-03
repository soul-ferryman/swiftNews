//
//  UserDetailBottomPopController.swift
//  News
//
//  Created by 经纬泰和 on 2019/1/2.
//  Copyright © 2019 经纬泰和. All rights reserved.
//

import UIKit



class UserDetailBottomPopController: UIViewController , UITableViewDelegate, UITableViewDataSource, NibLoadable{

    @IBOutlet weak var tableView: UITableView!
    
    var bottomTabChildren = [BottomTabChildren]()
    
    var didSelectedChild:((BottomTabChildren)->())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self 
        
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")
        
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bottomTabChildren.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(UITableViewCell.self)", for:indexPath)
        cell.selectionStyle = .none
        let child = bottomTabChildren[indexPath.row]
        cell.textLabel?.text = child.name
        cell.textLabel?.textAlignment = .center 
        cell.textLabel?.font = UIFont.systemFont(ofSize: 8)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: MyPresentationControllerDismiss), object: nil)
        
        didSelectedChild?(bottomTabChildren[indexPath.row])
    }
    

}
