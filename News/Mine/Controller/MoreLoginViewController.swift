//
//  MoreLoginViewController.swift
//  News
//
//  Created by 经纬泰和 on 2018/12/4.
//  Copyright © 2018 经纬泰和. All rights reserved.
//

import UIKit
import IBAnimatable

class MoreLoginViewController: AnimatableModalViewController {

    @IBOutlet weak var loginClosedButton: UIButton!
    //顶部标题
    @IBOutlet weak var topLabel: UILabel!
    //手机号 view
    @IBOutlet weak var mobileView: AnimatableView!
    //验证码 view
    @IBOutlet weak var passwrodView: AnimatableView!
    //发送验证码 view
    @IBOutlet weak var sendVerifyView: UIView!
    //找回密码 view
    @IBOutlet weak var findPasswordView: UIView!
    //发送验证码按钮
    @IBOutlet weak var sendVerifyButton: UIButton!
    //手机号 输入框
    @IBOutlet weak var mobileTextField: UITextField!
    //找回密码按钮
    @IBOutlet weak var findPasswordButton: UIButton!
    //密码输入框
    @IBOutlet weak var passwordtextField: UITextField!
    //未注册
    @IBOutlet weak var middleTipLabel: UILabel!
    //进入头条
    @IBOutlet weak var enterTouTiaoButton: AnimatableButton!
    //阅读条款
    @IBOutlet weak var readLabel: UILabel!
    //阅读按钮
    @IBOutlet weak var readButton: UIButton!
    //账号密码登录
    @IBOutlet weak var loginModeButton: UIButton!
    
    @IBOutlet weak var wechatLoginButton: UIButton!
    
    @IBOutlet weak var qqLoginButton: UIButton!
    @IBOutlet weak var tianyiLoginButton: UIButton!
    @IBOutlet weak var mailLoginButton: UIButton!
    @IBAction func readButtonClicked(_ sender: UIButton) {
        readButton.isSelected = !readButton.isSelected
    }
    @IBAction func loginModeButtonClicked(_ sender: UIButton) {
        loginModeButton.isSelected = !loginModeButton.isSelected
        sendVerifyView.isHidden = sender.isSelected
        findPasswordView.isHidden = !sender.isSelected
        middleTipLabel.isHidden = sender.isSelected
        passwordtextField.placeholder = sender.isSelected ? "密码" : "请输入验证码"
        topLabel.text = sender.isSelected ? "账号密码登录" : "登录你的头条，精彩永不消失"
    }
    @IBAction func moreLoginCloseButtonClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loginModeButton .setTitle("免密码登录", for: .selected)
        view.theme_backgroundColor = "colors.cellBackfroundColor"
        topLabel.theme_textColor = "colors.black"
        middleTipLabel.theme_textColor = "colors.cellRightTextColor"
        readLabel.theme_textColor = "colors.black"
        enterTouTiaoButton.theme_backgroundColor = "colors.enterTouTiaoBackgroundColors"
        enterTouTiaoButton.theme_setTitleColor("colors.enterTouTiaoTextColors", forState: .normal)
        readButton.theme_setImage("images.loginReadButton", forState: .selected)
        readButton.theme_setImage("images.loginReadButtonSelected", forState: .normal)
        mobileView.theme_backgroundColor = "colors.loginMobileViewBackgroundColor"
        passwrodView.theme_backgroundColor = "colors.loginMobileViewBackgroundColor"
        loginClosedButton.theme_setImage("images.loginClosedButtonImage", forState: .normal)
        wechatLoginButton.theme_setImage("images.moreLoginWechatButton", forState: .normal)
        qqLoginButton.theme_setImage("images.moreLoginQQButton", forState: .normal)
        tianyiLoginButton.theme_setImage("images.moreLoginTianyiButton", forState: .normal)
        mailLoginButton.theme_setImage("images.moreLoginMailButton", forState: .normal)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
