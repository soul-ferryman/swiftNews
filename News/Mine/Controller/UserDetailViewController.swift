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
            if userDetail.bottom_tab.count == 0 {
                self.bottomViewBotton.constant = 0
                self.headerView.layoutIfNeeded()
            }else {
                //赋值到bottomview上
                self.bottomView.addSubview(self.myBottomView)
                self.myBottomView.bottomTabs = userDetail.bottom_tab
            }
            
            
            
        }
        
    }
    
    //懒加载
    fileprivate lazy var headerView:UserDetailHeader = {
        let headerView = UserDetailHeader.loadViewFromeNib()
        return headerView
    }()
    
    fileprivate lazy var myBottomView:UserDetailBottomView = {
        let myBottomView = UserDetailBottomView(frame: self.bottomView.bounds)
        myBottomView.delegate = self
        return myBottomView
    }()
    
   

}

extension UserDetailViewController:UserDetailBottomViewDelegate {
    
    //bottomButton 点击
    func bottomView(clicked button:UIButton, bottomTab:BottomTab) {
        
        let bottomPushVC = UserDetailBottomPushController()
        bottomPushVC.navigationItem.title = "网页浏览"
        
        if bottomTab.children.count == 0 {
            //直接跳转到下一控制器
            bottomPushVC.url = bottomTab.value
            navigationController?.pushViewController(bottomPushVC, animated: true)
            
        }else {
            //弹出子视图
            
            let sb = UIStoryboard(name: "\(UserDetailBottomPopController.self)", bundle: nil)
            let popoverVC = sb.instantiateViewController(withIdentifier: "\(UserDetailBottomPopController.self)") as! UserDetailBottomPopController
            popoverVC.bottomTabChildren = bottomTab.children
            popoverVC.didSelectedChild = {(bottomTabChildren:BottomTabChildren) in
                bottomPushVC.url = bottomTabChildren.value
                self.navigationController?.pushViewController(bottomPushVC, animated: true)
            }
            
            //自定义转场动画
            popoverVC.modalPresentationStyle = .custom
            let popoverAnimator = PopoverAnimator()
            //转换frame
            let rect = myBottomView.convert(button.frame, to: view)
            let popWidth = (ScreenWidth - CGFloat(userDetail!.bottom_tab.count + 1)*20)/CGFloat(userDetail!.bottom_tab.count)
            let popX = CGFloat(button.tag) * (popWidth + 20) + 20
            let popHeight = CGFloat(bottomTab.children.count)  * 40 + 25
            popoverAnimator.presentnFrame = CGRect(x: popX, y: rect.origin.y - popHeight, width: popWidth, height: popHeight)
            popoverVC.transitioningDelegate = popoverAnimator
            
            
            present(popoverVC, animated: true, completion: nil)
            
        }
    }
    
   
}
