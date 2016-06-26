//
//  BTSingInTVC.swift
//  BanTang
//
//  Created by 张灿 on 16/6/26.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit

class BTSingInTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let topView = BTSingTopView()
        topView.frame = CGRect(x: 0, y: 0, width: BTscreenW, height: 385)
        tableView.tableHeaderView = topView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier")
        
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "reuseIdentifier")
        }
        
        if indexPath.row == 0 {
            
            cell!.textLabel?.text = "您有0张补签卡"
            cell?.textLabel?.font = UIFont.systemFontOfSize(16)
            cell?.textLabel?.textColor = UIColor.lightGrayColor()
            
        } else {
            cell = NSBundle.mainBundle().loadNibNamed("BTSingNumberCell", owner: nil, options: nil).first as! BTSingNumberCell
        }


        return cell!
    }



}
