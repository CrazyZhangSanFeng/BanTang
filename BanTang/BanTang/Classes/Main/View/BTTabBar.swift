//
//  BTTabBar.swift
//  BanTang
//
//  Created by 张灿 on 16/5/23.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit

class BTTabBar: UITabBar {
    
    //MARK:- photo按钮的懒加载
    lazy var button : UIButton = {
       var button = UIButton(type: .Custom)
        button.setImage(UIImage(named: "tab_publish_add_36x32_"), forState: .Normal)
        button.setImage(UIImage(named: "tab_publish_add_pressed_36x32_"), forState: .Selected)
        
        button.sizeToFit()
        
        button.addTarget(self, action: #selector(photoClick), forControlEvents: .TouchUpInside)
        
        self.addSubview(button)
        
        return button
        
    }()
    
    
    //MARK:- 重写布局
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let count : NSInteger = (self.items?.count)!
        
        var x : CGFloat = 0
        let y : CGFloat = 0
        let w : CGFloat = self.bounds.size.width / CGFloat(count + 1)
        let h : CGFloat = self.bounds.size.height
        
        var i = 0
        for button: UIView in self.subviews {
            if button.isKindOfClass(NSClassFromString("UITabBarButton")!) {
                if i == 2 {
                    i = i + 1
                }
                x = CGFloat(i) * w
                
                button.frame = CGRectMake(x, y, w, h)
                
                i += 1

            }
        }
        
        self.button.center.x = self.bounds.size.width * 0.5
        self.button.center.y = self.bounds.size.height * 0.5
        
    }
    
    func photoClick() {
        let photoVC = UIImagePickerController()
        photoVC.sourceType = .PhotoLibrary
        
        [self.window?.rootViewController?.presentViewController(photoVC, animated: true, completion: nil)]
    }


}
