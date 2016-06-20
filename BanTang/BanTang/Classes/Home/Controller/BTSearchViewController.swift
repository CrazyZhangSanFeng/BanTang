//
//  BTSearchViewController.swift
//  BanTang
//
//  Created by 张灿 on 16/6/19.
//  Copyright © 2016年 张灿. All rights reserved.
// 搜索 控制器

import UIKit

class BTSearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitl()
    }
    
    func setTitl() {
        // 这个是必要的设置
        automaticallyAdjustsScrollViewInsets = false
        
        var style = SegmentStyle()
        //标题不滚动
        style.scrollTitle = false
        
        // 缩放文字
        style.scaleTitle = true
        // 颜色渐变
        style.gradualChangeTitleColor = true
        
        style.selectedTitleColor = UIColor(red: 235.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        
        
        let titles = setChildVcs().map { $0.title! }
        
        let scroll = ScrollPageView(frame: CGRect(x: 0, y: 64, width: view.bounds.size.width, height: view.bounds.size.height - 64), segmentStyle: style, titles: titles, childVcs: setChildVcs(), parentViewController: self)
        view.addSubview(scroll)
    }
    
    func setChildVcs() -> [UIViewController] {
        let vc1 = BTSearchDanpinViewController()
        vc1.title = "单品"
        
        let vc2 = BTSearchListVC()
        
        vc2.title = "清单"
        
        return [vc1, vc2]
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
