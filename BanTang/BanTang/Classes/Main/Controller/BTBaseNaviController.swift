//
//  BTBaseNaviController.swift
//  BanTang
//
//  Created by 张灿 on 16/5/23.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit

class BTBaseNaviController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.barTintColor = UIColor.whiteColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //自定义全局返回按钮,push隐藏底部栏
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        if self.childViewControllers.count > 0 {
            //创建按钮
            let btn = UIButton(type: .Custom)
            btn.setImage(UIImage(named: "public_back_btn_44x44_"), forState: .Normal)
            btn.sizeToFit()
            
            btn.addTarget(self, action: #selector(back), forControlEvents: .TouchUpInside)
            btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 0)
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
            
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    //返回按钮
    func back() {
        self.popViewControllerAnimated(true)
    }

}
