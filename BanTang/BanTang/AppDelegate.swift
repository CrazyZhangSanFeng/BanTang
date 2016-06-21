//
//  AppDelegate.swift
//  BanTang
//
//  Created by 张灿 on 16/5/23.
//  Copyright © 2016年 张灿. All rights reserved.
//  友盟Appkey: 57680cace0f55ae81f003319

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //友盟授权
        UMSocialData.setAppKey("57680cace0f55ae81f003319")
        // 隐藏没有安装的平台(因为苹果的审核政策要求)
        UMSocialConfig.hiddenNotInstallPlatforms([UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline, UMShareToWechatFavorite])
        
        //设置微信AppId、appSecret，分享url
        UMSocialWechatHandler.setWXAppId("wxd930ea5d5a258f4f", appSecret: "db426a9829e4b49a0dcac7b4162da6b6", url: "http://www.umeng.com/social")
        
        //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
        UMSocialQQHandler.setQQWithAppId("100424468", appKey: "c7394704798a158208a74ab60104f0ba", url: "http://www.umeng.com/social")
        //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
        UMSocialSinaSSOHandler.openNewSinaSSOWithAppKey("3921700954", secret: "04b48b094faeb16683c32669824ebdad", redirectURL: "http://sns.whalecloud.com/sina2/callback")
        
        
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let mainVC = BTMainTabBarVC()
        
        self.window?.rootViewController = mainVC
        
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    // 当别的APP打开我们APP 的时候(通过URL地址), 就会调用这个方法
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        
        let result = UMSocialSnsService.handleOpenURL(url)
        if !result {
            //调用其他SDK，例如支付宝SDK等
        }
        return result
        
        
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        let result = UMSocialSnsService.handleOpenURL(url)
        if !result {
            //调用其他SDK，例如支付宝SDK等
        }
        return result
        
    }
    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        let result = UMSocialSnsService.handleOpenURL(url)
        if !result {
            //调用其他SDK，例如支付宝SDK等
        }
        return result
        
    }


    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

