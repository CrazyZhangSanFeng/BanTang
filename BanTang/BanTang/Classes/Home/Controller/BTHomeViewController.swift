//
//  BTHomeViewController.swift
//  BanTang
//
//  Created by 张灿 on 16/5/23.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit
import SDCycleScrollView

private let collCellID = "collCellID"
class BTHomeViewController: UITableViewController {
   
    var collectionView: UICollectionView?
    var titleView: UIScrollView?
    var titleButtons: [UIButton]?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        //设置导航条透明
        setupNaviBar()
        
        //设置图片轮播
        tableView.tableHeaderView = setupCyclePicture()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        tableView.scrollsToTop = false
        
        //添加所有子控制器
        setupAllChildVC()
        
        
    }

}

//MARK:- 设置导航条透明
extension BTHomeViewController {
    func setupNaviBar() {

        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        //签到按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "home_sign_icon_33x33_"), highlightImage: UIImage(named: "home_sign_highlight_icon_33x33_"), target: self, action: #selector(signClick))
        //搜索按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "home_search_icon_33x33_"), highlightImage: nil, target: self, action: #selector(searchClick))

    }
}

//导航条按钮点击
extension BTHomeViewController {
    func signClick() {
        debugPrint("签到点击")
    }
    
    func searchClick() {
        debugPrint("搜索点击")
    }
}

//MARK:- 设置图片轮播
extension BTHomeViewController: SDCycleScrollViewDelegate {

    func setupCyclePicture() -> SDCycleScrollView {
        let cycleScrollView: SDCycleScrollView = SDCycleScrollView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 162), delegate: self, placeholderImage: UIImage(named: "default_user_icon_75x75_"))
//        cycleScrollView.imageURLStringsGroup = ["","",""]
        cycleScrollView.currentPageDotColor = UIColor.yellowColor()
        
        return cycleScrollView
    }
    
}

//MARK:- 设置滚动标题栏
extension BTHomeViewController {
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        titleView = UIScrollView()
        titleView!.backgroundColor = UIColor.orangeColor()
        titleView!.scrollsToTop = false
        return titleView
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 0.定义标示
        let cellID = "CellID"
        
        // 1.从缓冲池中取出cell
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID)
        
        // 2.判断是否取出cell
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellID)
        }
        
        // 3.给cell设置数据
        cell?.contentView.addSubview(setupBottomView())
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UIScreen.mainScreen().bounds.height
    }
    
    
 //MARK:- 透明效果实现
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let offset: CGFloat = tableView.contentOffset.y
        
        var alpha: CGFloat = offset * 1 / 98.0
        
        if alpha <= 0 {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        if alpha >= 1 {
            alpha = 0.99
            tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 64, right: 0)
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "home_sign_top_icon_19x19_"), highlightImage: nil, target: self, action: #selector(signClick))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "home_sign_icon_33x33_"), highlightImage: UIImage(named: "home_sign_highlight_icon_33x33_"), target: self, action: #selector(signClick))
        }
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(color: UIColor(white: 1.0, alpha: alpha)), forBarMetrics: .Default)
    }
    
}

 //MARK:- 创建底部视图
extension BTHomeViewController {
    func setupBottomView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
        layout.scrollDirection = .Horizontal
        
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height) , collectionViewLayout: layout)
        
        collectionView!.scrollsToTop = false
        collectionView!.dataSource = self
        collectionView!.delegate = self
        collectionView!.pagingEnabled = true
        collectionView!.showsHorizontalScrollIndicator = false
        
        collectionView!.registerClass(NSClassFromString("UICollectionViewCell"), forCellWithReuseIdentifier: collCellID)
        
        return collectionView!
    }
}

//MARK:- collectionView数据源,代理
extension BTHomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.childViewControllers.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(collCellID, forIndexPath: indexPath)
        //移除之前的所有控制器
        cell.contentView.subviews.map{
            $0.removeFromSuperview()
        }
        //获取相对应的控制器
        let vc = self.childViewControllers[indexPath.row] 
        
        vc.view.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
        cell.contentView.addSubview(vc.view)
        
        return cell
    }

}

//MARK:- 添加所有子控制器
extension BTHomeViewController {
    
    func setupAllChildVC() {
        //最新
        let newVC = UITableViewController()
        newVC.title = "最新"
        self.addChildViewController(newVC)
        
        //用户原创
        let userVC = UITableViewController()
        userVC.title = "用户原创"
        self.addChildViewController(userVC)
        
        //一周最热
        let hotVC = UITableViewController()
        hotVC.title = "一周最热"
        self.addChildViewController(hotVC)
        
        //美妆&穿搭
        let wearVC = UITableViewController()
        wearVC.title = "美妆&穿搭"
        self.addChildViewController(wearVC)
        
        //美食
        let foodVC = UITableViewController()
        foodVC.title = "美食"
        self.addChildViewController(foodVC)
        
        //设计感
        let designVC = UITableViewController()
        designVC.title = "设计感"
        self.addChildViewController(designVC)
        
        //礼物
        let giftVC = UITableViewController()
        giftVC.title = "礼物"
        self.addChildViewController(giftVC)
        
    }
}

//MARK:- 添加所有标题
extension BTHomeViewController {
    func setupAllTitle() {
        let count = self.childViewControllers.count
        var x: CGFloat = 0
        let y: CGFloat = 0
        let w: CGFloat = UIScreen.mainScreen().bounds.width / 4
        let h: CGFloat = (titleView?.frame.size.height)!
        
        for i in 0..<count {
            let vc = self.childViewControllers[i]
            let button = UIButton(type: .Custom)
            button.setTitle(vc.title, forState: .Normal)
            button.tag = i
            button.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
            button.setTitleColor(UIColor.redColor(), forState: .Selected)
            button.titleLabel?.font = UIFont.boldSystemFontOfSize(15)
            x = CGFloat(i) * w
            button.frame = CGRect(x: x, y: y, width: w, height: h)
            button.addTarget(self, action: #selector(BTHomeViewController.buttonClick(_:)), forControlEvents: .TouchUpInside)
            titleView?.addSubview(button)
            titleButtons?.append(button)
            //默认选中第一个
            if i == 0 {
                
            }
            
            
        }
    }
}

//MARK:- 按钮点击
extension BTHomeViewController {

    func buttonClick(button: UIButton) {
        
    }

}


