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
        shareView.frame.origin.y = BTscreenH
        UIApplication.sharedApplication().keyWindow?.addSubview(shareView)
        UIView.animateWithDuration(0.25) { 
            shareView.frame.origin.y = BTscreenH - shareView.frame.size.height
        }
        return shareView
    }

}
