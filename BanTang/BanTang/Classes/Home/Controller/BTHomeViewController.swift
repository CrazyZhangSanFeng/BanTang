//
//  BTHomeViewController.swift
//  BanTang
//
//  Created by 张灿 on 16/5/23.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit
import SDCycleScrollView
class BTHomeViewController: UITableViewController {
   
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        //设置导航条透明
        setupNaviBar()
        
        //设置图片轮播
        tableView.tableHeaderView = setupCyclePicture()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        
        
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
        let titleView = UIScrollView()
        titleView.backgroundColor = UIColor.orangeColor()
        
        return titleView
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
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
        cell?.textLabel?.text = "测试数据:\(indexPath.row)"
        
        return cell!
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
