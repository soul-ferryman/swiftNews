//
//  UserDetailViewController.swift
//  News
//
//  Created by 经纬泰和 on 2018/12/17.
//  Copyright © 2018 经纬泰和. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomViewBotton: NSLayoutConstraint!
    
    
    var userId:Int = 0
    
    var userDetail:UserDetail?
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        scrollView.addSubview(headerView)
        scrollView.contentSize = CGSize(width: ScreenWidth, height: 1000)
        bottomViewBotton.constant = isIPhoneX ? 34:0
        view.layoutIfNeeded()
        
        NetworkTool.loadUserDetail(user_id: userId) { (userDetail) in
            self.userDetail = userDetail
            self.headerView.userDetail = userDetail
        }
        
    }
    
    //懒加载
    fileprivate lazy var headerView:UserDetailHeader = {
        let headerView = UserDetailHeader.headerView()
        return headerView
    }()

}
