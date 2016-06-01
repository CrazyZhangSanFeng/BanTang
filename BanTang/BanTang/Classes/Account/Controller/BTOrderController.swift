//
//  BTOrderController.swift
//  BanTang
//
//  Created by 张灿 on 16/5/31.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit

class BTOrderController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //背景色
        tableView.backgroundColor = UIColor(red: 244 / 255.0, green: 244 / 255.0, blue: 244 / 255.0, alpha: 1.0)
        //取消系统分割线
        tableView.separatorStyle = .None
        
        self.title = "订单中心"
    }


}
