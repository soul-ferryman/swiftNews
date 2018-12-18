//
//  MyNavigationController.swift
//  News
//
//  Created by 经纬泰和 on 2018/11/13.
//  Copyright © 2018 经纬泰和. All rights reserved.
//

import UIKit

class MyNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let navgationBar  = UINavigationBar.appearance()
        navgationBar.theme_barTintColor = "colors.cellBackfroundColor"
        navgationBar.theme_tintColor = "colors.navgationBarTintColor"
        
        //全局拖拽手势
        initGlobalPan()
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "lefterbackicon_titlebar_24x24_"), style: .plain, target: self, action: #selector(navigationBack))
        }
        super.pushViewController(viewController, animated: true)
    }
    
    @objc private func navigationBack() {
        popViewController(animated: true)
    }
    

    

}


extension MyNavigationController: UIGestureRecognizerDelegate {
    //全局拖拽手势
    fileprivate func initGlobalPan() {
        
        //创建pan手势
        let target = interactivePopGestureRecognizer?.delegate
        
        let globalPan = UIPanGestureRecognizer(target: target, action: Selector(("handleNavigationTransition:")))
        
        globalPan.delegate = self
        
        view.addGestureRecognizer(globalPan)

        //禁止系统手势
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count != 1
    }
}
