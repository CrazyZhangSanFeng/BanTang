//
//  BTBaseTVC.swift
//  BanTang
//
//  Created by 张灿 on 16/6/5.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit
// MARK: BTBaseTVCDelegate
protocol BTBaseTVCDelegate: class {
    func scrollViewIsScrolling(scrollView: UIScrollView)
    func setupTableViewOffSetYWhenViewWillAppear(scrollView: UIScrollView)
}

class BTBaseTVC: UIViewController {
    
    // 代理
    weak var delegate: BTBaseTVCDelegate?
    
    //
    var tableView: UITableView!
    
    func setupTableView() {
        tableView = UITableView(frame: self.view.bounds, style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 240
        tableView.separatorStyle = .None
        
        //        tableView.bounces = false
        // 设置背景色
        //        tableView.backgroundColor = UIColor.clearColor()
        //        let headView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: view.bounds.size.width, height: defaultOffSetY))
        //        tableView.tableHeaderView = headView
        
        // 设置tableview的内容偏移量
        tableView.contentInset = UIEdgeInsets(top: defaultOffSetY, left: 0, bottom: 49, right: 0)
        self.view.addSubview(tableView)
    }
    
    
    /// !!! 不要在viewDidLoad()方法里面设置tableView或者collectionView的偏移量, 在初始化方法中设置偏移量,否则可能导致显示不正常
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //        print(tableView.contentOffset.y)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

// MARK: UITableViewDelegate, UITableViewDataSource - 这里测试使用, 实际使用中可以重写这些方法
extension BTBaseTVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cellId")
        cell.textLabel?.text = "未继承--------ceshishishihi"
        
        return cell
    }
}



// MARK: UIScrollViewDelegate - 监控tableview的滚动, 将改变通知给通知父控制器
extension BTBaseTVC: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        delegate?.scrollViewIsScrolling(scrollView)
    }
}
