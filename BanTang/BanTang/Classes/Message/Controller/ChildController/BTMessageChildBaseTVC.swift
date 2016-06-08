//
//  BTMessageChildBaseTVC.swift
//  BanTang
//
//  Created by 张灿 on 16/6/8.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit

class BTMessageChildBaseTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor(red: 244 / 255.0, green: 244 / 255.0, blue: 244 / 255.0, alpha: 1.0)
        
        //设置tableView的背景图片(没有消息)
        setupBackgroundView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */
}

//MARK:- 设置tableView的背景图片(没有消息)
extension BTMessageChildBaseTVC {
    func setupBackgroundView() {
        let backgroundV = UIView(frame: CGRect(x: 95, y: 170, width: 127, height: 164))
        backgroundV.backgroundColor = UIColor.clearColor()
        
        let label = UILabel()
        label.text = "没有收到任何消息"
        label.frame = CGRect(x: 0, y: 147, width: 127, height: 17)
        label.textColor = UIColor.lightGrayColor()
        label.font = UIFont.systemFontOfSize(15)
        backgroundV.addSubview(label)
        
        
        let imageview = UIImageView(image: UIImage(named: "bg_message_empty_127x127_"))
        imageview.frame = CGRect(x: 0, y: 0, width: 127, height: 127)
        backgroundV.addSubview(imageview)
        
        let contentV = UIView()
        
        contentV.addSubview(backgroundV)
        
        tableView.backgroundView = contentV
    }
}
