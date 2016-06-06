//
//  BTBaseRequestParmas.swift
//  BanTang
//
//  Created by 张灿 on 16/6/6.
//  Copyright © 2016年 张灿. All rights reserved.
//
/*
 http://open3.bantangapp.com/
 recommend/index?
 app_id=com.jzyd.BanTang
 &app_installtime=1463934108
 &app_versions=5.8
 &channel_name=appStore
 &client_id=bt_app_ios
 &client_secret=9c1e6634ce1c5098e056628cd66a17a5
 &os_versions=9.3.2
 &page=0
 &pagesize=20
 &screensize=640
 &track_device_info=iPhone6%2C2
 &track_deviceid=EAC59F1B-C110-48FA-B013-02A92744278A
 &v=13
 
 
 app_id	com.jzyd.BanTang
 app_installtime	1463934108
 app_versions	5.8.1
 channel_name	appStore
 client_id	bt_app_ios
 client_secret	9c1e6634ce1c5098e056628cd66a17a5
 last_get_time	1465194195
 oauth_token	f1d476369a332f4e16f578a6228bd97e
 os_versions	9.3.2
 page	0
 pagesize	20
 screensize	640
 track_device_info	iPhone6,2
 track_deviceid	EAC59F1B-C110-48FA-B013-02A92744278A
 track_user_id	2182968
 v	13
 */

import UIKit

class BTBaseRequestParmas: NSObject {
    
    var app_id: String = "com.jzyd.BanTang"
    var app_installtime: String = "1463934108"
    var app_versions: String = "5.8.1"
    var channel_name: String = "appStore"
    var client_id: String = "bt_app_ios"
    var client_secret: String = "9c1e6634ce1c5098e056628cd66a17a5"
    var last_get_time: String = "1465194195"
    var oauth_token: String = "f1d476369a332f4e16f578a6228bd97e"
    var os_versions: String = "9.3.2"
    var page: NSInteger = 0
    var pagesize: NSInteger = 20
    var screensize: CGFloat = 640
    var track_device_info: String = "iPhone6,2"
    var track_deviceid: String = "EAC59F1B-C110-48FA-B013-02A92744278A"
    var track_user_id: String = "2182968"
    var v: String = "13"

    
    class func parmas() ->BTBaseRequestParmas {
        return BTBaseRequestParmas.init()
    }
    
    

}
