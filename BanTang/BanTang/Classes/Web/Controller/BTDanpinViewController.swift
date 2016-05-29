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
private let hotUrl = "http://open3.bantangapp.com/community/post/hotRecommend?app_id=com.jzyd.BanTang&app_installtime=1463934108&app_versions=5.8&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&oauth_token=f1d476369a332f4e16f578a6228bd97e&os_versions=9.3.2&page=0&pagesize=18&screensize=640&track_device_info=iPhone6%2C2&track_deviceid=EAC59F1B-C110-48FA-B013-02A92744278A&track_user_id=2182968&v=13"
//列
private let cols: CGFloat = 3
//间距
private let margin: CGFloat = 2
private let wh = (UIScreen.mainScreen().bounds.width - (cols - 1) * margin) / cols

class BTDanpinViewController: UITableViewController {
    
    //分类模型数组
    lazy var categoryItems : [BTCategoryItem]? = [BTCategoryItem]()
    
    //热门推荐模型数组
    lazy var hotItems: [BTHotItem]? = [BTHotItem]()
    
    var footView: BTHotView?
    
    
    var page: NSInteger = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //注册cell
        tableView.registerNib(UINib.init(nibName: "BTCategoryCell", bundle: nil), forCellReuseIdentifier: cell0ID)
        
        //加载底部collectionView
        setupFooterView()
        
        //请求数据
        loadHotData(page)
        
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

//MARK:- 设置底部collectionView
extension BTDanpinViewController {
    func setupFooterView() {

        let footV = NSBundle.mainBundle().loadNibNamed("BTHotView", owner: nil, options: nil).first as! BTHotView
        
        tableView.tableFooterView = footV
        
        footView = footV
    }
}


//MARK:- 底部数据请求
extension BTDanpinViewController {
    func loadHotData(page: NSInteger) {
        let manager = AFHTTPSessionManager()
        
        manager.GET("http://open3.bantangapp.com/community/post/hotRecommend?app_id=com.jzyd.BanTang&app_installtime=1463934108&app_versions=5.8&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&oauth_token=f1d476369a332f4e16f578a6228bd97e&os_versions=9.3.2&page=\(page)&pagesize=18&screensize=640&track_device_info=iPhone6%2C2&track_deviceid=EAC59F1B-C110-48FA-B013-02A92744278A&track_user_id=2182968&v=13", parameters: nil, progress: nil, success: { (_, response) in
            //将AnyObject转化成字典类型
            guard (response as? [String : NSObject]) != nil else {
                return
            }
            
            let dictArray = response!["data"] as? [[String : NSObject]]
            
            
            
            let arrs = BTHotItem.mj_objectArrayWithKeyValuesArray(dictArray) as! [BTHotItem]
            
            for item:BTHotItem in arrs {
                self.hotItems?.append(item)
            }
            
            self.footView?.hotItems = self.hotItems
            
            //重新设置collectionView高度
            let maxRows = (self.hotItems!.count - 1) / 3 + 1
            let h: CGFloat = CGFloat(maxRows) * wh + CGFloat(maxRows) * margin
            self.footView?.frame.size.height = h + 49
            self.tableView.tableFooterView = self.footView
            
            self.tableView.reloadData()
            
            }) { (_, error) in
                //请求失败调用
        }
    }
}
