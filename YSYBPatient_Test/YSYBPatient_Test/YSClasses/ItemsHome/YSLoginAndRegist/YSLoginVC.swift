//
//  YSLoginVC.swift
//  YSYBPatient_Test
//
//  Created by YJ on 17/5/8.
//  Copyright © 2017年 YJ. All rights reserved.
//

import UIKit

class YSLoginVC: YSRootVC {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)


    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.initUIAndData()
        self.createScrollView()
        self.createAccountAndPassword()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initUIAndData() -> () {

    }

    func createScrollView() -> () {
        let scrollContentView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 200))
        scrollContentView.backgroundColor = kMainColor
        self.view.addSubview(scrollContentView)
    }

    func createAccountAndPassword() -> () {
        let contentView:UIView = UIView(frame: CGRect(x: 0, y: 200, width: kScreenWidth, height: kScreenHeight - 200))
        contentView.backgroundColor = kDefaultBackgroundColor
        self.view.addSubview(contentView)

        let acPassBackgroundView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 91))
        acPassBackgroundView.backgroundColor = UIColor.white
        contentView.addSubview(acPassBackgroundView)

        let accountTextDeild = UITextField(frame: CGRect(x: 15, y: 0, width: kScreenWidth-15, height: 45))
        accountTextDeild.keyboardType = .numbersAndPunctuation
        accountTextDeild.leftView = UIImageView(image: UIImage(named: "hx_icon_number"))
        accountTextDeild.leftViewMode = .always
        accountTextDeild.placeholder = "账号"
        acPassBackgroundView.addSubview(accountTextDeild)

        let middleLine:UIView = UIView(frame: CGRect(x: 0, y: 45, width: kScreenWidth, height: 1))
        middleLine.backgroundColor = kDefaultBackgroundColor
        acPassBackgroundView.addSubview(middleLine)

        let passwordTextFeild = UITextField(frame: CGRect(x: 15, y: 46, width: kScreenWidth-15, height: 45))
        passwordTextFeild.keyboardType = .default
        passwordTextFeild.leftViewMode = .always
        passwordTextFeild.placeholder = "密码"
        passwordTextFeild.leftView = UIImageView(image: UIImage(named: "hx_icon_code"))
        acPassBackgroundView.addSubview(passwordTextFeild)

        let fogetPassWord:UIButton = UIButton(type:.custom)
        fogetPassWord.frame = CGRect(x: kScreenWidth - 80 - 15, y: acPassBackgroundView.frame.maxY + 10, width: 80, height: 30)
        fogetPassWord.setBackgroundImage(UIImage(named: "hx_icon_login_forget"), for: UIControlState.normal)
        fogetPassWord.addTarget(self, action: #selector(clickForgetPassword(button:)), for: UIControlEvents.touchUpInside)
        contentView.addSubview(fogetPassWord)

        let loginBtn:UIButton = UIButton(type: .custom)
        loginBtn.frame = CGRect(x: 15, y: fogetPassWord.frame.maxY+10, width: (kScreenWidth-3*15)/2, height: 40)
        loginBtn.setBackgroundImage(UIImage(named: "hx_icon_login"), for: UIControlState.normal)
        loginBtn.setTitle("登录", for: UIControlState.normal)
        loginBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        loginBtn.addTarget(self, action: #selector(clickLogin(button:)), for: .touchUpInside)
        contentView.addSubview(loginBtn)

        let registBtn:UIButton = UIButton(type: .custom)
        registBtn.frame = CGRect(x: loginBtn.frame.maxX+15, y: fogetPassWord.frame.maxY+10, width: (kScreenWidth-3*15)/2, height: 40)
        registBtn.setBackgroundImage(UIImage(named: "hx_icon_register"), for: UIControlState.normal)
        registBtn.setTitle("注册", for: UIControlState.normal)
        registBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        registBtn.addTarget(self, action: #selector(clickRegist(button:)), for: .touchUpInside)
        contentView.addSubview(registBtn)

        let infoLabel = UILabel(frame: CGRect(x: 0, y: contentView.frame.height - 30, width: kScreenWidth, height: 30))
        infoLabel.text = "app责任归属说明"
        infoLabel.font = kDefaultSystemFont
        infoLabel.textAlignment = .center
        infoLabel.textColor = kRGBColorFromHex(rgbValue: 0x999999)
        contentView.addSubview(infoLabel)
    }

    func clickForgetPassword(button: UIButton) {
        // 忘记密码
        let forgetVC = YSRegistOrForgetPassVC()
        self.navigationController?.pushViewController(forgetVC, animated: true)
    }

    func clickLogin(button: UIButton) {
        // 登录
    }

    func clickRegist(button: UIButton) {
        // 注册
    }
}



