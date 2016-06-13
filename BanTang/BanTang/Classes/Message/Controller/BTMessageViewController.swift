//
//  BTMessageViewController.swift
//  BanTang
//
//  Created by 张灿 on 16/5/23.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit

class BTMessageViewController: UIViewController {
    //标题滚动栏
    var titleScrollView: UIScrollView = {
        
        var titlescroll = UIScrollView()
        titlescroll.frame = CGRect(x: 0, y: 64, width: UIScreen.mainScreen().bounds.width, height: 44)
        titlescroll.backgroundColor = UIColor.whiteColor()
        return titlescroll
    }()
    //容器滚动栏
    var contentScrollView: UIScrollView = {
        var content = UIScrollView()
        content.frame = CGRect(x: 0, y: 108, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height - 108 - 49)
        content.pagingEnabled = true
        content.showsHorizontalScrollIndicator = false
        
        return content
    
    }()
    var underLine: UIView?
//    var selectBtn: UIButton?
    var titleBtns: [UIButton] = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置导航栏标题,字体颜色等
        setupNavTitle()
        
        setupScrollView()
        
        
        addAllChildVC()
        setupTitleView()
        
        view.backgroundColor = UIColor(red: 244 / 255.0, green: 244 / 255.0, blue: 244 / 255.0, alpha: 1.0)
        
        automaticallyAdjustsScrollViewInsets = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //设置导航栏标题,字体颜色等
    func setupNavTitle() {
        navigationItem.title = "消息"
        
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(19), NSForegroundColorAttributeName: UIColor.darkGrayColor()]
    }

}

extension BTMessageViewController: UIScrollViewDelegate {
    
    //设置两个滚动代理
    func setupScrollView() {
        titleScrollView.delegate = self
        view.addSubview(titleScrollView)
        contentScrollView.delegate = self
        view.addSubview(contentScrollView)
    }
    
    //添加所有子控制器
    func addAllChildVC() {
        let vc1 = BTMessageChildBaseTVC()
        vc1.title = "喜欢/收藏"
        
        self.addChildViewController(vc1)
        
        let vc2 = BTMessageChildBaseTVC()
        vc2.title = "评论"
        
        self.addChildViewController(vc2)
        
        let vc3 = BTMessageChildBaseTVC()
        vc3.title = "通知"
        
        self.addChildViewController(vc3)
    }
    
    //设置标题栏
    func setupTitleView() {
        let count: NSInteger = self.childViewControllers.count
        var x: CGFloat = 0
        let y: CGFloat = 0
        let w: CGFloat = UIScreen.mainScreen().bounds.width / CGFloat(count)
        let h: CGFloat = (titleScrollView.frame.size.height)
        
        for i in 0..<count {
            let vc = self.childViewControllers[i]
            
            let btn = UIButton(type: .Custom)
            
            btn.setTitle(vc.title, forState: .Normal)
            btn.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
            btn.setTitleColor(UIColor.darkGrayColor(), forState: .Selected)
            btn.tag = i
            
            btn.titleLabel?.font = UIFont.systemFontOfSize(15)
            
            x = CGFloat(i) * w
            btn.frame = CGRect(x: x, y: y, width: w, height: h)
            
            titleScrollView.addSubview(btn)
            
            btn.addTarget(self, action: #selector(BTMessageViewController.btnClick(_:)), forControlEvents: .TouchUpInside)
            titleBtns.append(btn)
            
            if i == 0 {
                btnClick(btn)
                underLine = UIView()
                underLine?.backgroundColor = UIColor.redColor()
                underLine?.frame.size.height = 3
                underLine?.frame.size.width = 30
                underLine?.frame.origin.y = titleScrollView.frame.size.height - 3
                underLine?.center.x = btn.center.x
                titleScrollView.addSubview(underLine!)
                
            }
        }
        
        titleScrollView.contentSize = CGSize(width: w * CGFloat(count), height: 0)
        contentScrollView.contentSize = CGSize(width: UIScreen.mainScreen().bounds.width * CGFloat(count), height: 0)
    }
    
    //按钮点击
    func btnClick(btn: UIButton) {
        let i = btn.tag
//        btnChange(btn)
        setupChildVC(i)
        UIView.animateWithDuration(0.25) { 
            
            self.underLine?.center.x = btn.center.x
        }
        let x = CGFloat(i) * UIScreen.mainScreen().bounds.width
        contentScrollView.contentOffset = CGPoint(x: x, y: 0)
    }
    
    func setupChildVC(i: NSInteger) {
        let vc = childViewControllers[i]
        if (vc.view.superview != nil) {
            return
        }
        
        let x = CGFloat(i) * UIScreen.mainScreen().bounds.width
        
        vc.view.frame = CGRect(x: x, y: 0, width: contentScrollView.bounds.size.width, height: contentScrollView.bounds.size.height)
        
        contentScrollView.addSubview(vc.view)
    }
    
//    func btnChange(btn: UIButton) {
//        selectBtn = btn
//        UIView.animateWithDuration(0.25) {
//            
//            self.underLine?.center.x = btn.center.x
//        }
//    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let page = contentScrollView.contentOffset.x / UIScreen.mainScreen().bounds.width
        
//        let btn = titleBtns[NSInteger(page)]
        
//        btnChange(btn)
        
        setupChildVC(NSInteger(page))
    }
    
    //动态计算下划线位置
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let page = contentScrollView.contentOffset.x / UIScreen.mainScreen().bounds.width

        underLine?.center.x =  BTscreenW / CGFloat(titleBtns.count) * 0.5 + page * BTscreenW / CGFloat(titleBtns.count)
        
    }
}




