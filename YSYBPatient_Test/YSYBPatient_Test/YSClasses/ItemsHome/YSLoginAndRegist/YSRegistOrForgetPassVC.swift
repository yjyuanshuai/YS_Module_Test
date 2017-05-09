//
//  YSRegistVC.swift
//  YSYBPatient_Test
//
//  Created by YJ on 17/5/8.
//  Copyright © 2017年 YJ. All rights reserved.
//

import UIKit

class YSRegistOrForgetPassVC: YSRootVC {

    var currentType:Enum_LoginPushVCType = Enum_LoginPushVCType.pushToForget

//    func initWithLoginPushToType(_ currentVCType: Enum_LoginPushVCType) -> YSRegistOrForgetPassVC {
//
//    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
