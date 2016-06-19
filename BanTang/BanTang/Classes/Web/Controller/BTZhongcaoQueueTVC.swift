//
//  BTZhongcaoQueueTVC.swift
//  BanTang
//
//  Created by 张灿 on 16/6/19.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit

private let cellID = "zhongcaocell"

class BTZhongcaoQueueTVC: UITableViewController {
    
    //模型数组
    var zhongcaoItems: [BTZhongcaoItem] = [BTZhongcaoItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //取消系统分割线
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor(red: 244 / 255.0, green: 244 / 255.0, blue: 244 / 255.0, alpha: 1.0)
        
        //注册cell
        tableView.registerNib(UINib.init(nibName: "BTZhongcaoCell", bundle: nil), forCellReuseIdentifier: cellID)
        
        //cell高度
        tableView.rowHeight = (BTscreenW - 20) * 0.4
        
        loadData()
    }
    
    func loadData() {
        BTHomePageDataTool.getZhongcaoQueueData({ (zhongcaoItems, error) in
            if error != nil {
                return
            }
            self.zhongcaoItems = zhongcaoItems!
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return zhongcaoItems.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID) as! BTZhongcaoCell
        
        cell.zhongcaoItem = zhongcaoItems[indexPath.row]
        
        cell.selectionStyle = .None

        return cell
    }
    
    //组头部
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return NSBundle.mainBundle().loadNibNamed("BTZhongcaoHeaderView", owner: nil, options: nil).first as? UIView
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 43
    }
    
    //组尾部
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return NSBundle.mainBundle().loadNibNamed("BTZhongcaoFooterView", owner: nil, options: nil).first as? UIView
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 43
    }

    
}
