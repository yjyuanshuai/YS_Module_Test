//
//  YSTabBarController.swift
//  YSYBPatient_Test
//
//  Created by YJ on 17/5/5.
//  Copyright © 2017年 YJ. All rights reserved.
//

import UIKit

class YSTabBarController: UITabBarController {
    
    //
    var firstPageNav:UINavigationController = UINavigationController()
    var healthFileNav:UINavigationController = UINavigationController()
    var noticeNav:UINavigationController = UINavigationController()
    var healthEduNav:UINavigationController = UINavigationController()
    var meNav:UINavigationController = UINavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.createAllNavs()
        
        self.selectedIndex = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // 创建 Navs
    func createAllNavs() -> () {
        let firstPageVC:YSFirstPageVC = YSFirstPageVC()
        firstPageVC.tabBarItem = UITabBarItem(title:"首页", image:UIImage(named:"tab_firstpage_unselected"), selectedImage: UIImage(named:"tab_firstpage_selected"))
        firstPageNav = UINavigationController(rootViewController:firstPageVC)
        
        let healthFileVC:YSHealthFileVC = YSHealthFileVC()
        firstPageVC.tabBarItem = UITabBarItem(title:"健康档案", image:UIImage(named:"tab_healthfile_unselected"), selectedImage: UIImage(named:"tab_healthfile_selected"))
        healthFileNav = UINavigationController(rootViewController:healthFileVC)
        
        let noticeVC:YSNoticeVC = YSNoticeVC()
        firstPageVC.tabBarItem = UITabBarItem(title:"消息", image:UIImage(named:"tab_notice_unselected"), selectedImage: UIImage(named:"tab_notice_selected"))
        noticeNav = UINavigationController(rootViewController:noticeVC)
        
        let healthEduVC:YSHealthEduVC = YSHealthEduVC()
        firstPageVC.tabBarItem = UITabBarItem(title:"健康教育", image:UIImage(named:"tab_healthedu_unselected"), selectedImage: UIImage(named:"tab_healthedu_selected"))
        healthEduNav = UINavigationController(rootViewController:healthEduVC)
        
        let meVC:YSMeVC = YSMeVC()
        firstPageVC.tabBarItem = UITabBarItem(title:"我", image:UIImage(named:"tab_me_unselected"), selectedImage: UIImage(named:"tab_me_selected"))
        meNav = UINavigationController(rootViewController:meVC)
        
        self.viewControllers = [firstPageNav, healthFileNav, noticeNav, healthEduNav, meNav]
    }
}
