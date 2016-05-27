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

private let listUrlStr = "http://open3.bantangapp.com/community/post/index?app_id=com.jzyd.BanTang&app_installtime=1463934108&app_versions=5.8&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&oauth_token=f1d476369a332f4e16f578a6228bd97e&os_versions=9.3.2&screensize=640&track_device_info=iPhone6%2C2&track_deviceid=EAC59F1B-C110-48FA-B013-02A92744278A&track_user_id=2182968&v=13"


class BTDanpinViewController: UITableViewController {
    
    //模型数组懒加载
    lazy var categoryItems : [BTCategoryItem]? = [BTCategoryItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //注册cell
        tableView.registerNib(UINib.init(nibName: "BTCategoryCell", bundle: nil), forCellReuseIdentifier: cell0ID)
        
        tableView.backgroundColor = UIColor.orangeColor()
        
        //加载分类数据
        loadDanpinData()
        
        
    }

}

// MARK: - Table view 数据源
extension BTDanpinViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cell0ID, forIndexPath: indexPath) as! BTCategoryCell
        
        
        cell.categoryItems = categoryItems!
        
        print("\(categoryItems!.count)分类cell")
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 367
    }
    
}

//MARK:- 请求分类数据
extension BTDanpinViewController {
    func loadDanpinData() {
       //创建会话管理者
        let manager = AFHTTPSessionManager()
        
        manager.GET(listUrlStr, parameters: nil, progress: nil, success: { (_, response) in
            
            
//            response?.writeToFile("/Users/zhangcan/Desktop/fenlei.plist", atomically: true)
            guard (response as? [String : NSObject]) != nil else {
                return
            }
            let dataDict = response!["data"] as? [String : NSObject]
            let category_listArray = dataDict!["category_list"] as? [[String : NSObject]]
                    
            self.categoryItems = BTCategoryItem.mj_objectArrayWithKeyValuesArray(category_listArray) as! [BTCategoryItem]
                    
            print("\(self.categoryItems!.count)分类网络请求")
                    
            self.tableView.reloadData()
                
            
            
            }) { (_, error) in
                
        }
    
    }
}
