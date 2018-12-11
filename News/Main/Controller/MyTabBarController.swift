//
//  MyTabBarController.swift
//  News
//
//  Created by 经纬泰和 on 2018/11/13.
//  Copyright © 2018 经纬泰和. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(tabBar.subviews)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置tabbar的文字颜色
        
        let tabbar = UITabBar.appearance()
        
        tabbar.tintColor = UIColor(red: 245 / 255.0, green: 90 / 255.0, blue: 93 / 255.0, alpha: 1.0)
        
        
        //添加子控制器
        
        addChildViewController()
        
        NotificationCenter.default.addObserver(self, selector: #selector(receiveThmeme), name: NSNotification.Name(rawValue: dayOrNight), object: nil)
    
    }
    
    //接收到主题修改通知
    @objc func receiveThmeme(notification:Notification) {
        //
        let selected = notification.object as! Bool
        if selected {//设置为夜间
            for childController in viewControllers! {
                switch childController.tabBarItem.tag {
                case 0:
                    setNightChildController(controller: childController, imageName: "home")
                case 1:
                    setNightChildController(controller: childController, imageName: "video")
                case 2:
                    setNightChildController(controller: childController, imageName: "huoshan")
                case 3:
                    setNightChildController(controller: childController, imageName: "no_login")
                default:
                    break
                }
            }
            
        }else {//设置为日间
            for childController in viewControllers! {
                switch childController.tabBarItem.tag {
                case 0:
                    setDayChildController(controller: childController, imageName: "home")
                case 1:
                    setDayChildController(controller: childController, imageName: "video")
                case 2:
                    setDayChildController(controller: childController, imageName: "huoshan")
                case 3:
                    setDayChildController(controller: childController, imageName: "no_login")
                default:
                    break
                }
            }
        }
        
    }
    
    //设置夜间控制器
    private func setNightChildController(controller:UIViewController, imageName:String){
        controller.tabBarItem.image = UIImage(named: imageName + "_tabbar_night_32x32_")
        controller.tabBarItem.selectedImage = UIImage(named: imageName + "_tabbar_press_night_32x32_")
    }
    //设置日间控制器
    private func setDayChildController(controller:UIViewController, imageName:String){
        controller.tabBarItem.image = UIImage(named: imageName + "_tabbar_32x32_")
        controller.tabBarItem.selectedImage = UIImage(named: imageName + "_tabbar_press_32x32_")
    }
    
    
    //添加子控制器
    private func addChildViewController()  {
       
        setChildViewController(HomeViewController(), title: "首页", imageName: "home",  itemTag: 0)
        
        setChildViewController(VideoViewController(), title: "视频", imageName: "video",  itemTag: 1)
        
        setChildViewController(HuoShanViewController(), title: "火山", imageName: "huoshan", itemTag: 2)
        
        setChildViewController(MineViewController.init(style: .grouped) , title: "未登录", imageName: "no_login",  itemTag: 3)
        
        //tabBar是readonly属性，不能直接修改，利用KVC吧readonly属性的权限改过来
        setValue(MyTabBar(), forKey: "tabBar")
    }

    //初始化子控制器
    private func setChildViewController(_ childController: UIViewController, title: String, imageName:String, itemTag: Int) {
        
        if UserDefaults.standard.bool(forKey: isNight) {
            setNightChildController(controller: childController, imageName: imageName)
        }else {
            setDayChildController(controller: childController, imageName: imageName)
        }
        
        //设置tabbar 文字和图片
        childController.tabBarItem.title = title
        childController.title = title
        childController.tabBarItem.tag = itemTag
        
        let navVC = MyNavigationController.init(rootViewController: childController)
        addChild(navVC)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //监听tabbar的点击事件
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(item.tag)
    }

}
