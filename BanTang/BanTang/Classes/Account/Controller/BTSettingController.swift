//
//  BTSettingController.swift
//  BanTang
//
//  Created by 张灿 on 16/5/30.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit

class BTSettingController: UITableViewController {
    
  //清理缓存
    @IBOutlet weak var cleanLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor(red: 244 / 255.0, green: 244 / 255.0, blue: 244 / 255.0, alpha: 1.0)

        tableView.sectionFooterHeight = 1
    }
//夜间模式
    @IBAction func nightClick(sender: UISwitch) {
        debugPrint("夜间模式")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }


}

extension BTSettingController {
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       
        return 10
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.section,indexPath.row)
    }
}
