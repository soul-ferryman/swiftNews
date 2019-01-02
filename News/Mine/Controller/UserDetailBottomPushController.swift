//
//  UserDetailBottomPushController.swift
//  News
//
//  Created by 经纬泰和 on 2019/1/2.
//  Copyright © 2019 经纬泰和. All rights reserved.
//

import UIKit
import WebKit

class UserDetailBottomPushController: UIViewController {
    
    var url:String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let webView = WKWebView()
        webView.frame = view.bounds
        webView.load(URLRequest(url: URL(string: url!)!))
        
        view.addSubview(webView)
        
    }


}
