//
//  BTHomeViewController.swift
//  BanTang
//
//  Created by 张灿 on 16/5/23.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit
import SDCycleScrollView

/// 这些常量请根据项目需要修改
let segmentViewHeight: CGFloat = 44.0
let naviBarHeight: CGFloat = 64.0
let headViewHeight: CGFloat = 162.0
let defaultOffSetY: CGFloat = segmentViewHeight + headViewHeight

class BTHomeViewController: UIViewController, SDCycleScrollViewDelegate {
    
    var childVcs:[BTBaseTVC] = []
    var currentChildVc: BTBaseTVC!
    
    var banners: [BTHomeBanner] = [BTHomeBanner]()
    var muarray: [AnyObject] = [AnyObject]()
    /// 用来实时记录子控制器的tableView的滚动的offSetY
    var offSetY: CGFloat = -defaultOffSetY
    
    /// 当前的偏移量, 用于处理下拉刷新 或者其他需要和偏移量同步的动画效果
    var currentOffsetY: CGFloat = 0 {
        didSet {
//            print(currentOffsetY)
        }
    }
    // 懒加载 containerView 所有view的容器
    lazy var containerView: UIView = {
        let containerView = UIView(frame: self.view.bounds)
        containerView.backgroundColor = UIColor.whiteColor()
        return containerView
    }()
    
    // 懒加载 topView 悬停标题
    lazy var topView: ScrollSegmentView! = {[unowned self] in
        
        var style = SegmentStyle()
        
        // 颜色渐变
        style.gradualChangeTitleColor = true
        // 下划线
        style.showLine = true
        
        style.scrollLineColor = UIColor.redColor()
        
        // title正常状态颜色 使用RGB空间值
        style.normalTitleColor = UIColor(red: 98.0/255.0, green: 98.0/255.0, blue: 98.0/255.0, alpha: 1.0)
        // title选中状态颜色 使用RGB空间值
        style.selectedTitleColor = UIColor(red: 235.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        
        let titles = ["最新", "优惠", "一周最热", "美妆&穿搭", "美食", "设计感", "礼物", "文艺", "学生党"]
        
        let topView = ScrollSegmentView(frame: CGRect(x: CGFloat(0.0), y: headViewHeight, width: self.view.bounds.size.width, height: segmentViewHeight), segmentStyle: style, titles: titles)
        
        topView.titleBtnOnClick = {[unowned self] (label: UILabel, index: Int) in
            self.contentView.setContentOffSet(CGPoint(x: self.contentView.bounds.size.width * CGFloat(index), y: 0), animated: false)
            
        }
        topView.backgroundColor = UIColor.whiteColor()
        return topView
        
        }()
    
    // 懒加载 contentView
    lazy var contentView: ContentView! = {[unowned self] in
        let contentView = ContentView(frame: self.view.bounds, childVcs: self.childVcs, parentViewController: self)
        contentView.delegate = self // 必须实现代理方法
        return contentView
        }()
    
    // 懒加载 headView
    lazy var headView: SDCycleScrollView =  {
        let headView: SDCycleScrollView = SDCycleScrollView.init(frame: CGRect(x: 0.0, y: 0.0, width: self.view.bounds.size.width, height: headViewHeight), delegate: self, placeholderImage: UIImage(named: "default_user_icon_75x75_"))
        
        
        
        
        
        headView.currentPageDotColor = UIColor.yellowColor()
        
        
        return headView
    }()
    
    // 懒加载 scrollView headView的容器
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame:  CGRect(x: 0.0, y: 0.0, width: self.view.bounds.size.width, height: headViewHeight))
        scrollView.delegate = self
        scrollView.scrollsToTop = false
        scrollView.contentSize = CGSize(width: 0.0, height: headViewHeight*2)
        scrollView.scrollsToTop = false
        
        
        
        return scrollView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "半糖"
        view.backgroundColor = UIColor.whiteColor()
        // 这个是必要的设置, 如果没有设置导致显示内容不正常, 请尝试设置这个属性
        automaticallyAdjustsScrollViewInsets = false
        setupNaviBar()
        setChildVcs()
        
        addSubviews()
        
        // 添加通知监听每个页面的出现
        addNotificationObserver()
        loadBannerData()
    }
    
    //加载轮播图
    func loadBannerData() {
        BTHomePageDataTool.getBannerArray { (bannerArray) in
            self.headView.imageURLStringsGroup = bannerArray
        }
  
    }
    
    func addSubviews() {
        view.addSubview(containerView)
        // 1. 先添加contentView
        containerView.addSubview(contentView)
        scrollView.addSubview(headView)
        // 2. 再添加scrollView
        containerView.addSubview(scrollView)
        
        // 3. 再添加topView(topView必须添加在contentView的下面才可以实现悬浮效果)
        containerView.addSubview(topView)
    }
    
    func addNotificationObserver() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.didSelectIndex(_:)), name: ScrollPageViewDidShowThePageNotification, object: nil)
        
    }
    
    func didSelectIndex(noti: NSNotification) {
        let userInfo = noti.userInfo!
        //注意键名是currentIndex
        // 通知父控制器重新设置tableView的contentOffset.y
        let currentIndex = userInfo["currentIndex"] as! Int
        let childVc = childVcs[currentIndex]
        currentChildVc = childVc
        childVc.delegate?.setupTableViewOffSetYWhenViewWillAppear(childVc.tableView)
//        print(userInfo["currentIndex"])
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    //1. 添加子控制器为PageTableViewController或者继承自他的Controller,
    //   或者你可以参考PageTableViewController他里面的实现自行实现(可以使用UICollectionView)相关的代理和属性 并且设置delegate为self
    
    func setChildVcs() {
        let vc1 = BTNewController()
        
        vc1.delegate = self
        
        let vc2 = BTNewController()
        vc2.delegate = self
        
        let vc3 = BTNewController()
        vc3.delegate = self
        
        let vc4 = BTNewController()
        vc4.delegate = self
        
        let vc5 = BTNewController()
        vc5.delegate = self
        
        let vc6 = BTNewController()
        vc6.delegate = self
        
        let vc7 = BTNewController()
        vc7.delegate = self
        
        let vc8 = BTNewController()
        vc8.delegate = self
        
        let vc9 = BTNewController()
        vc9.delegate = self

        childVcs = [vc1, vc2, vc3,vc4, vc5, vc6, vc7, vc8, vc9]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

// MARK:- UIScrollViewDelegate
extension BTHomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        currentOffsetY = scrollView.contentOffset.y
        //        print(scrollView.contentOffset.y)
        headView.frame.origin.y = currentOffsetY
        if currentOffsetY < 0 {
            containerView.frame.origin.y = -currentOffsetY
            return
        }
        
        if currentChildVc.tableView.contentOffset.y == currentOffsetY - defaultOffSetY { return }
        currentChildVc.tableView.contentOffset.y = currentOffsetY - defaultOffSetY
        
        
//                let offset: CGFloat = scrollView.contentOffset.y
        
                var alpha: CGFloat = currentOffsetY * 1 / 98.0
        
        
                if alpha <= 0 {
        
                }
        
                if alpha >= 1 {
                    alpha = 0.99
                    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "home_sign_top_icon_19x19_"), highlightImage: nil, target: self, action: #selector(signClick))
                } else {
                    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "home_sign_icon_33x33_"), highlightImage: UIImage(named: "home_sign_highlight_icon_33x33_"), target: self, action: #selector(signClick))
                }
        
                navigationController?.navigationBar.setBackgroundImage(UIImage(color: UIColor(white: 1.0, alpha: alpha)), forBarMetrics: .Default)
        
        
        
    }
}

// MARK:- PageTableViewDelegate - 监控子控制器中的tableview的滚动和更新相关的UI
extension BTHomeViewController: BTBaseTVCDelegate {
    
    // 设置将要显示的tableview的contentOffset.y
    func setupTableViewOffSetYWhenViewWillAppear(scrollView: UIScrollView) {
        
        defer {
            offSetY = scrollView.contentOffset.y
        }
        //        print("\(offSetY) -------*\(scrollView.contentOffset.y)-----*\(-(naviBarHeight + segmentViewHeight)))")
        if offSetY < -(naviBarHeight + segmentViewHeight) {
            scrollView.contentOffset.y = offSetY
            return
        } else {
            if scrollView.contentOffset.y < -(naviBarHeight + segmentViewHeight) {
                
                scrollView.contentOffset.y = -(naviBarHeight + segmentViewHeight)
                // 使滑块停在navigationBar下面
                self.scrollView.frame.origin.y = naviBarHeight - headViewHeight
                topView.frame.origin.y = naviBarHeight
                return
            }
            return
            
        }
        
        
    }
    
    // 根据子控制器的scrolView的偏移量来调整UI
    func scrollViewIsScrolling(scrollView: UIScrollView) {
        offSetY = scrollView.contentOffset.y
        currentOffsetY = offSetY + defaultOffSetY
//                print("\(offSetY),tableview")
        
        if offSetY < -(defaultOffSetY - headViewHeight + naviBarHeight) {
            
            var alpha: CGFloat = currentOffsetY * 1 / 98.0
            
            
            if alpha <= 0 {
                
            }
            
            if alpha >= 1 {
                alpha = 0.99
                navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "home_sign_top_icon_19x19_"), highlightImage: nil, target: self, action: #selector(signClick))
            } else {
                navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "home_sign_icon_33x33_"), highlightImage: UIImage(named: "home_sign_highlight_icon_33x33_"), target: self, action: #selector(signClick))
            }
            
            navigationController?.navigationBar.setBackgroundImage(UIImage(color: UIColor(white: 1.0, alpha: alpha)), forBarMetrics: .Default)
            
        }
        
        
        if offSetY > -(defaultOffSetY - headViewHeight + naviBarHeight) {
            if topView.frame.origin.y == naviBarHeight {
                return
            }
            // 使滑块停在navigationBar下面
            self.scrollView.frame.origin.y = naviBarHeight - headViewHeight
            topView.frame.origin.y = naviBarHeight
            navigationController?.navigationBar.setBackgroundImage(UIImage(color: UIColor(white: 1.0, alpha: 1.0)), forBarMetrics: .Default)
            
            return
        } else if offSetY < -defaultOffSetY {
            
            topView.frame.origin.y = -offSetY - segmentViewHeight
            self.scrollView.frame.origin.y = topView.frame.origin.y - headViewHeight
            return
        } else {
            
            // 这里是让滑块和headView随着上下滚动
            //这种方式可能会出现同步的偏差问题
            //            headView.frame.origin.y -= deltaY
            //            topView.frame.origin.y -= deltaY
            // 这种方式会准确的同步位置
            topView.frame.origin.y = -offSetY - segmentViewHeight
            self.scrollView.frame.origin.y = topView.frame.origin.y - headViewHeight
            // 不加判断会触发self.scrollView的代理 相当于"递归", 会重复设置为相同的值
            if self.scrollView.contentOffset.y == currentOffsetY {
                return
            }
            self.scrollView.contentOffset.y = currentOffsetY
        }
        
    }
    
}


// MARK:- ContentViewDelegate
extension BTHomeViewController: ContentViewDelegate {
    var segmentView: ScrollSegmentView {
        return topView
    }
    
}



//MARK:- 导航条按钮点击
extension BTHomeViewController {
    func signClick() {
        debugPrint("签到点击")
    }
    
    func searchClick() {
        debugPrint("搜索点击")
    }
}


//MARK:- 设置导航条
extension BTHomeViewController {
    func setupNaviBar() {
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(color: UIColor(white: 1.0, alpha: 0.0)), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        //签到按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "home_sign_icon_33x33_"), highlightImage: UIImage(named: "home_sign_highlight_icon_33x33_"), target: self, action: #selector(signClick))
        //搜索按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "home_search_icon_33x33_"), highlightImage: nil, target: self, action: #selector(searchClick))
        
    }
}


