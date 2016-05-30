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
        
        //添加导航栏两侧按钮
        setNavButton()
        
        //顶部个人信息
        setupHeadView()
        
        //背景色
        tableView.backgroundColor = UIColor(red: 244 / 255.0, green: 244 / 255.0, blue: 244 / 255.0, alpha: 1.0)
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
    
    //MARK:- 设置悬停view
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerSection = NSBundle.mainBundle().loadNibNamed("BTMiddleView", owner: nil, options: nil).first as! BTMiddleView
        headerSection.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: 44)
        return headerSection
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    
}

//MARK:- 导航栏两侧按钮
extension BTAccountViewController {
    func setNavButton() {
        //添加导航栏右侧按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "settingicon_44x44_"), style: .Plain, target: self, action: #selector(setClick))
        
        //添加导航栏左侧按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "center_order_icon_44x44_"), style: .Done, target: self, action: #selector(centerClick))
        
        navigationItem.leftBarButtonItem?.imageInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
        navigationItem.rightBarButtonItem?.imageInsets = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 15)
        
    }
}

//MARK:- 导航栏按钮点击
extension BTAccountViewController {
    func setClick() {
        debugPrint("点击设置按钮")
        let storyboard = UIStoryboard.init(name: "BTSettingController", bundle: nil)
        
        let setVC = storyboard.instantiateInitialViewController() as! BTSettingController
        
        navigationController?.pushViewController(setVC, animated: true)
        
    }
    
    
    func centerClick() {
        debugPrint("点击中心按钮")
    }
}

//MARK:- 个人信息头部视图
extension BTAccountViewController {
    func setupHeadView() {
        
        let headView = NSBundle.mainBundle().loadNibNamed("BTUserHeadView", owner: self, options: nil).first as! BTUserHeadView
        
        headView.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: 132)
        
        tableView.tableHeaderView = headView
    }
}


