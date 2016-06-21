//
//  BTShareView.swift
//  BanTang
//
//  Created by 张灿 on 16/6/13.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit


class BTShareView: UIView {
    
    //模型
    var productModel: BTProductModel? {
        didSet {
            guard let productModel = productModel else {
                return
            }
            sharePic = productModel.share_pic
            shareUrl = productModel.share_url
            title = productModel.title
            desc = productModel.desc
        }
    }
    
    var shareUrl: String = ""
    var sharePic: String = ""
    var title: String = ""
    var desc: String = ""

    class func shareView() -> BTShareView {
        let shareView = NSBundle.mainBundle().loadNibNamed("BTShareView", owner: nil, options: nil).first as! BTShareView
        //刚开始在屏幕下面
        shareView.frame.origin.y = BTscreenH
        //添加到窗口
        UIApplication.sharedApplication().keyWindow?.addSubview(shareView)
        //做动画挪上来
        UIView.animateWithDuration(0.25) { 
            shareView.frame.origin.y = BTscreenH - shareView.frame.size.height
        }
        return shareView
    }
    
    //朋友圈分享
    @IBAction func friendCircleClick(sender: AnyObject) {
        
        UMSocialData.defaultData().extConfig.wechatSessionData.url = shareUrl
        //主标题
        UMSocialData.defaultData().extConfig.wechatSessionData.title = title
        //内容地址传进来
        let shareURL = UMSocialUrlResource(snsResourceType: UMSocialUrlResourceTypeImage, url: sharePic)
        
        UMSocialDataService.defaultDataService().postSNSWithTypes([UMShareToWechatTimeline], content: desc, image: nil, location: nil, urlResource: shareURL, presentedController: nil) { (response) -> Void in
            if response.responseCode.rawValue == UMSResponseCodeSuccess.rawValue {
                print("成功")
            }
        }
}
    
    //微信好友分享
    @IBAction func weChatFriendClick(sender: AnyObject) {
        
        UMSocialData.defaultData().extConfig.wechatSessionData.url = shareUrl
        //主标题
        UMSocialData.defaultData().extConfig.wechatSessionData.title = title
        //内容地址传进来
        let shareURL = UMSocialUrlResource(snsResourceType: UMSocialUrlResourceTypeImage, url: sharePic)
        
        UMSocialDataService.defaultDataService().postSNSWithTypes([UMShareToWechatSession], content: desc, image: nil, location: nil, urlResource: shareURL, presentedController: nil) { (response) -> Void in
            if response.responseCode.rawValue == UMSResponseCodeSuccess.rawValue {
                print("成功")
            }
        }
    }
    
    //新浪微博分享
    @IBAction func sinaClick(sender: AnyObject) {
        debugPrint("新浪微博分享")
    }
    
    //QQ好友分享
    @IBAction func QQfriendClick(sender: AnyObject) {
        debugPrint("QQ好友分享")
    }
    
    

}
