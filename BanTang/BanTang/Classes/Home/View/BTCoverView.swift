//
//  BTCoverView.swift
//  BanTang
//
//  Created by 张灿 on 16/6/13.
//  Copyright © 2016年 张灿. All rights reserved.
// 遮盖

import UIKit

class BTCoverView: UIView {
    
    //闭包作为属性
    var click: () -> Void = {
        
    }

    class func show() -> BTCoverView {
        let cover = BTCoverView()
        cover.frame = UIScreen.mainScreen().bounds
        cover.backgroundColor = UIColor.blackColor()
        cover.alpha = 0.4
        UIApplication.sharedApplication().keyWindow?.addSubview(cover)
        return cover
    }
    
    //点击屏幕调用闭包,类似代理
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.click()
    }

}
