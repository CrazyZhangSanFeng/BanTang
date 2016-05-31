//
//  BTMiddleView.swift
//  BanTang
//
//  Created by 张灿 on 16/5/30.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit

class BTMiddleView: UIView {

    @IBOutlet weak var underLineConst: NSLayoutConstraint!
    
    //单品点击
    @IBAction func danpinClick(sender: UIButton) {
        
        UIView.animateWithDuration(0.25) {
            
            self.underLineConst.constant = 0
            self.layoutIfNeeded()
        }
        debugPrint("单品点击")
        
    }
    
    //清单点击
    @IBAction func listClick(sender: UIButton) {
        UIView.animateWithDuration(0.25) {
            
            self.underLineConst.constant = sender.frame.size.width
            self.layoutIfNeeded()
        }
        debugPrint("清单点击")
        
    }
    
    //发布点击
    @IBAction func publishClick(sender: UIButton) {
        UIView.animateWithDuration(0.25) {
            
            self.underLineConst.constant = sender.frame.size.width * 2
            self.layoutIfNeeded()
        }
        debugPrint("发布点击")
        
    }

}
