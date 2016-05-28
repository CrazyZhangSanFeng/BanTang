//
//  BTDanpinViewController.swift
//  BanTang
//
//  Created by 张灿 on 16/5/26.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit
import MJExtension
import AFNetworking

private let cell0ID = "cell0"

class BTDanpinViewController: UITableViewController {
    
    //模型数组懒加载
    lazy var categoryItems : [BTCategoryItem]? = [BTCategoryItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //注册cell
        tableView.registerNib(UINib.init(nibName: "BTCategoryCell", bundle: nil), forCellReuseIdentifier: cell0ID)
        
        tableView.backgroundColor = UIColor.orangeColor()
    }

}

// MARK: - Table view 数据源
extension BTDanpinViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cell0ID, forIndexPath: indexPath) as! BTCategoryCell

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 367
    }
    
}
