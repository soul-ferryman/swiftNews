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
    
    /// 改变状态栏的字体颜色
    var changeStatusBarStyle: UIStatusBarStyle = .lightContent {
        didSet { setNeedsStatusBarAppearanceUpdate() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        scrollView.addSubview(headerView)
        scrollView.contentSize = CGSize(width: ScreenWidth, height: 1000)
        bottomViewBotton.constant = isIPhoneX ? 34:0
        scrollView.delegate = self
        view.addSubview(navigationView)
        view.layoutIfNeeded()
        
        NetworkTool.loadUserDetail(user_id: userId) { (userDetail) in
            self.userDetail = userDetail
            self.headerView.userDetail = userDetail
            self.navigationView.userDetail = userDetail
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
    
    fileprivate lazy var navigationView:NavigationBarView = {
        let navigationView = NavigationBarView.loadViewFromeNib()
       
        navigationView.goBackClicked = {
            self.navigationController?.popViewController(animated: true)
        }
        return navigationView
    }()
    

}

extension UserDetailViewController:UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offsetY = scrollView.contentOffset.y
        
        //图片黏住顶部拉伸
        if offsetY < -44 {
            let totalOffset = kUserDetailHeaderBGImageViewHeight + abs(offsetY)
            let f = totalOffset / kUserDetailHeaderBGImageViewHeight
            headerView.backgroundImageView.frame = CGRect(x: -ScreenWidth * (f - 1) * 0.5, y: offsetY, width: ScreenWidth * f, height: totalOffset)
            navigationView.backgroundColor = UIColor(white: 1.0, alpha: 0.0)
        }else {
            
            var alpha:CGFloat = (offsetY + 44)/58
            alpha = min(alpha, 1.0)
            navigationView.backgroundColor = UIColor(white: 1.0, alpha: alpha)
            if alpha == 1.0 {
                changeStatusBarStyle = .default
                navigationView.returnButton.theme_setImage("images.personal_home_back_black_24x24_", forState: .normal)
                navigationView.moreButton.theme_setImage("images.new_more_titlebar_24x24_", forState: .normal)
            } else {
                changeStatusBarStyle = .lightContent
                navigationView.returnButton.theme_setImage("images.personal_home_back_white_24x24_", forState: .normal)
                navigationView.moreButton.theme_setImage("images.new_morewhite_titlebar_22x22_", forState: .normal)
            }
            
            var alphaNavItem:CGFloat = offsetY/57
            
            
            //14+15+14
            if offsetY >= 43 {
                
                alphaNavItem = min(alphaNavItem, 1.0)
                navigationView.concernButton.isHidden = false
                navigationView.nameLabel.isHidden = false
                navigationView.concernButton.alpha = alphaNavItem
                navigationView.nameLabel.alpha = alphaNavItem
                navigationView.nameLabel.textColor = UIColor(r: 0, g: 0, b: 0, alpha: alphaNavItem)
                
            }else {
                alphaNavItem = min(0.0, alphaNavItem)
                navigationView.nameLabel.alpha = alphaNavItem
                navigationView.nameLabel.textColor = UIColor(r: 0, g: 0, b: 0, alpha: alphaNavItem)
                navigationView.concernButton.alpha = alphaNavItem
            }
            
            
        }
        
       
        
    }
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
