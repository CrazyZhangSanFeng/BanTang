//
//  BTShareView.swift
//  BanTang
//
//  Created by 张灿 on 16/6/13.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit

class BTShareView: UIView {

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

}
