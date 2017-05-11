//
//  ProjectEnvSetting.swift
//  YSYBPatient_Test
//
//  Created by YJ on 17/5/8.
//  Copyright © 2017年 YJ. All rights reserved.
//

import Foundation


var YS_YBPATIENT_HTTP_SERVER:String = ""

var YS_YBPATIENT_USER_CENTER_SERVER:String = ""




#if DEV

//    YS_YBPATIENT_USER_CENTER_SERVER = "https://dev-passport.yibaomd.com/m/"

#elseif LANRELEASE

#elseif OUTSIDERELEASE

#elseif APPSTORE

#endif
