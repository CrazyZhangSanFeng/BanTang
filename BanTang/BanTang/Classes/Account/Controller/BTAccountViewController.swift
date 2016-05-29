//
//  BTAccountViewController.swift
//  BanTang
//
//  Created by 张灿 on 16/5/23.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit

class BTAccountViewController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        //添加导航栏右侧按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "settingicon_44x44_"), style: .Plain, target: self, action: #selector(setClick))
        
        //添加导航栏左侧按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "center_order_icon_44x44_"), style: .Done, target: self, action: #selector(centerClick))
        
        navigationItem.leftBarButtonItem?.imageInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
        navigationItem.rightBarButtonItem?.imageInsets = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 15)
        
        setupHeadView()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerSection = UIView()
        headerSection.backgroundColor = UIColor.yellowColor()
        return headerSection
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    
}

//MARK:- 导航栏按钮点击
extension BTAccountViewController {
    func setClick() {
        debugPrint("点击设置按钮")
    }
    
    
    func centerClick() {
        debugPrint("点击中心按钮")
    }
}

//MARK:- 个人信息头部视图
extension BTAccountViewController {
    func setupHeadView() {
        
        let headView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: 131))
        headView.backgroundColor = UIColor.greenColor()
        tableView.tableHeaderView = headView
    }
}
