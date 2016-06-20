//
//  BTListViewController.swift
//  BanTang
//
//  Created by 张灿 on 16/5/26.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit
import AFNetworking
import MJExtension
import SwiftyJSON
    
    
    private let cellID = "cellID"
    class BTListViewController: UITableViewController {
        
        var page : NSInteger = 0
        //加载动画
        var loadingView: BTLoadingView?
        //模型数组
        lazy var topicItems: [BTTopicItem] = [BTTopicItem]()

        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            //取消系统分割线
            tableView.separatorStyle = .None
            tableView.backgroundColor = UIColor(red: 244 / 255.0, green: 244 / 255.0, blue: 244 / 255.0, alpha: 1.0)
     
            
            //设置Tabl头部视图
            let header = NSBundle.mainBundle().loadNibNamed("BTHeaderView", owner: nil, options: nil).first as! BTHeaderView
            let w = UIScreen.mainScreen().bounds.width
            header.frame = CGRect(x:0, y: 0, width:w,height:44)
            tableView.tableHeaderView = header
            
            //注册cell
            tableView.registerNib(UINib.init(nibName: "BTDisTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
            
            loadingView = BTLoadingView.shareInstance.loadingViewToView(self.view) as? BTLoadingView
            loadingView?.startAnimation()
            view.addSubview(loadingView!)
            
            //加载数据
            loadData(page)

        }
        
        
        // MARK: - Table view 数据源 代理方法
        
        override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return topicItems.count
        }
        
        override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! BTDisTableViewCell
            
            cell.topicItem = topicItems[indexPath.row]
            
            cell.selectionStyle = .None
            
            // 3.判断是否是最后一个cell即将出现
            if indexPath.row == topicItems.count - 1 {
                if page < 3 {
                    
                    page += 1
                    loadData(page)
                }
                
            }
            
            
            
            return cell
        }
        
        override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            return 220
        }
        
    }
    
    //MARK:- 请求数据
    extension BTListViewController {
        func loadData(page : NSInteger) {
            //创建会话管理者
            let manager = AFHTTPSessionManager()
            
            //配置请求参数
            
            //发送请求
            manager.GET("http://open3.bantangapp.com/topics/topic/listByUsers?app_id=com.jzyd.BanTang&app_installtime=1463934108&app_versions=5.8&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&oauth_token=f1d476369a332f4e16f578a6228bd97e&os_versions=9.3.2&page=\(page)&pagesize=20&screensize=640&sort_type=1&track_device_info=iPhone6%2C2&track_deviceid=EAC59F1B-C110-48FA-B013-02A92744278A&track_user_id=2182968&v=13", parameters: nil, progress: nil, success: { (_, responseObject) in
                
                self.loadingView?.hideAnimation()
                //将AnyObject转化成字典类型
                guard (responseObject as? [String : NSObject]) != nil else {
                    return
                }
                
                let dictArray = responseObject!["data"] as? [String : NSObject]
                let resultArray = dictArray!["topic"] as? [[String : NSObject]]
                
                var tempArrs = []
                
                tempArrs = BTTopicItem.mj_objectArrayWithKeyValuesArray(resultArray)
                
                
                for item in tempArrs {
                    self.topicItems.append(item as! BTTopicItem)
                }
                
                
                self.tableView.reloadData()
                
            }) { (_, error) in
                //请求失败调用
                self.loadingView?.hideAnimation()
            }
            
        }
    }


