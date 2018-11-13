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
        
        //tabBar是readonly属性，不能直接修改，利用KVC吧readonly属性的权限改过来
        setValue(MyTabBar(), forKey: "tabBar")
    
    }
    
    
    //添加子控制器
    func addChildViewController()  {
       
        setChildViewController(HomeViewController(), title: "首页", imageName: "home_tabbar_32x32_", selectedImageName: "home_tabbar_press_32x32_", itemTag: 0)
        
        setChildViewController(VideoViewController(), title: "视频", imageName: "video_tabbar_32x32_", selectedImageName: "video_tabbar_press_32x32_", itemTag: 1)
        
        setChildViewController(HuoShanViewController(), title: "火山", imageName: "huoshan_tabbar_32x32_", selectedImageName: "huoshan_tabbar_press_32x32_", itemTag: 2)
        
        setChildViewController(MineViewController(), title: "我的", imageName: "mine_tabbar_32x32_", selectedImageName: "mine_tabbar_press_32x32_", itemTag: 3)
        
    }

    //初始化子控制器
    func setChildViewController(_ childController: UIViewController, title: String, imageName:String, selectedImageName: String, itemTag: Int) {
        
        //设置tabbar 文字和图片
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: selectedImageName)
        childController.tabBarItem.title = title
        childController.title = title
        childController.tabBarItem.tag = itemTag
        
        let navVC = MyNavigationController.init(rootViewController: childController)
        addChild(navVC)
        
    }
    
    //监听tabbar的点击事件
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(item.tag)
    }

}
