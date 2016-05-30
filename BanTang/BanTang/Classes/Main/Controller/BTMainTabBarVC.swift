//
//  BTMainTabBarVC.swift
//  BanTang
//
//  Created by 张灿 on 16/5/23.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit

class BTMainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //加载子控制器
        setupAllChildVC()
        //自定义tabbar
        setupTabBarButton()
        
        view.backgroundColor = UIColor.whiteColor()
        
    }

}

//MARK:- 加载所有子控制器(photo除外)
extension BTMainTabBarVC {
    func setupAllChildVC() {
        //首页
        let homeVC = BTHomeViewController()
        setupOneChildVC(homeVC, imageName: "tab_首页_24x24_", selectImageName: "tab_首页_pressed_24x24_", title: "首页")
        
        //发现
        let discoverVC = BTDiscoverViewController()
        setupOneChildVC(discoverVC, imageName: "tab_社区_26x26_", selectImageName: "tab_社区_pressed_26x26_", title: "发现")
        
        //消息
        let messageVC = BTMessageViewController()
        setupOneChildVC(messageVC, imageName: "tab_分类_27x21_", selectImageName: "tab_分类_pressed_27x21_", title: "消息")
        
        //账号
        let accountVC = BTAccountViewController()
        setupOneChildVC(accountVC, imageName: "tab_我的_22x23_", selectImageName: "tab_我的_pressed_22x23_", title: "账号")
        
    }
}


//MARK:- 设置子控制器
extension BTMainTabBarVC {
    func setupOneChildVC(viewController: UIViewController, imageName: String, selectImageName: String, title: String?) {
        
        
        let baseNav = BTBaseNaviController(rootViewController: viewController)
        
//        viewController.navigationItem.title = title
//        viewController.tabBarItem.title = nil
        viewController.tabBarItem.image = UIImage(named: imageName)
        viewController.tabBarItem.selectedImage = UIImage(named: selectImageName)
        viewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        self.addChildViewController(baseNav)
    }
}

//MARK:- 自定义tabBar按钮
extension BTMainTabBarVC {
    func setupTabBarButton() {
        //创建自定义tabbar
        let tabbar = BTTabBar()
        self.setValue(tabbar, forKey: "tabBar")
    }
}