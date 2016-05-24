//
//  BTDiscoverViewController.swift
//  BanTang
//
//  Created by 张灿 on 16/5/23.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit
import AFNetworking
import MJExtension

private let cellID = "cellID"
class BTDiscoverViewController: UITableViewController {
    
    //模型数组
    lazy var topicItems: [BTTopicItem] = [BTTopicItem]()
    
    //下划线属性
    let underLine = UIView()
    //懒加载左侧按钮
    lazy var leftButton: UIButton = {
        
        var leftButton = UIButton(type: .Custom)
        leftButton.setTitle("清单", forState: .Normal)
        leftButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        leftButton.setTitleColor(UIColor.redColor(), forState: .Selected)
        leftButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        leftButton.frame = CGRectMake(5, 0, 57.5, 44)
        leftButton.selected = true
        leftButton.addTarget(self, action: #selector(BTDiscoverViewController.clickLeft), forControlEvents: .TouchUpInside)
        
        return leftButton
    }()
    
    //懒加载右侧按钮
    lazy var rightButton: UIButton = {
        
        var rightButton = UIButton(type: .Custom)
        rightButton.setTitle("单品", forState: .Normal)
        rightButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        rightButton.setTitleColor(UIColor.redColor(), forState: .Selected)
        rightButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        rightButton.frame = CGRectMake(67.5, 0, 57.5, 44)
        rightButton.addTarget(self, action: #selector(BTDiscoverViewController.clickRight), forControlEvents: .TouchUpInside)
        
        return rightButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //添加左侧关注按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "discovey_pop_btn_20x20_"), highlightImage: UIImage(named: "discovey_pop_press_btn_20x20_"), target: self, action: #selector(BTDiscoverViewController.attentation))
        
        //添加右侧创建按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "discover_write_article_icon_18x20_"), highlightImage: UIImage(named: "discover_write_article_highlisht_icon_19x20_"), target: self, action: #selector(BTDiscoverViewController.creatText))
        
        //添加导航栏中间的按钮
        setupTitleView()
        
        
        //设置Tabl头部视图
        let header = NSBundle.mainBundle().loadNibNamed("BTHeaderView", owner: nil, options: nil).first as! BTHeaderView
        let w = UIScreen.mainScreen().bounds.width
        header.frame = CGRect(x:0, y: 0, width:w,height:44)
        tableView.tableHeaderView = header
        
        //注册cell
        tableView.registerNib(UINib.init(nibName: "BTDisTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
        
        //加载数据
        loadData()
    
    }


    // MARK: - Table view 数据源 代理方法

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return topicItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! BTDisTableViewCell
        
        cell.topicItem = topicItems[indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 210
    }

}

//MARK:- 请求数据
extension BTDiscoverViewController {
    func loadData() {
        //创建会话管理者
        let manager = AFHTTPSessionManager()
        
        //配置请求参数
        
        //发送请求
        manager.GET("http://open3.bantangapp.com/topics/topic/listByUsers?app_id=com.jzyd.BanTang&app_installtime=1463934108&app_versions=5.8&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&oauth_token=f1d476369a332f4e16f578a6228bd97e&os_versions=9.3.2&page=0&pagesize=20&screensize=640&sort_type=1&track_device_info=iPhone6%2C2&track_deviceid=EAC59F1B-C110-48FA-B013-02A92744278A&track_user_id=2182968&v=13", parameters: nil, success: { (task: NSURLSessionDataTask, responseObject: AnyObject?) in
            
            //将AnyObject转化成字典类型
            guard (responseObject as? [String : NSObject]) != nil else {
                return
            }
            
            let dictArray = responseObject!["data"] as? [String : NSObject]
            let resultArray = dictArray!["topic"] as? [[String : NSObject]]
            self.topicItems = BTTopicItem.mj_objectArrayWithKeyValuesArray(resultArray) as! [BTTopicItem]
            
            self.tableView.reloadData()
            
        }) { (task: NSURLSessionDataTask?, error: NSError) in
            
        }
    }
}

//MARK:- 导航栏左右两侧的点击
extension BTDiscoverViewController {
    //MARK:- 关注点击
    func attentation() {
        print("关注")
    }
    //MARK:- 创建文章点击
    func creatText() {
        print("创建文章")
    }
}

//MARK:- 设置导航栏中间的view
extension BTDiscoverViewController {
    

    
    func setupTitleView() {
        //创建容器
        let contentView = UIView(frame: CGRectMake(0, 0, 130, 44))
        
        //创建红色下划线
        underLine.backgroundColor = UIColor.redColor()
        underLine.frame.size.width = leftButton.frame.size.width - 20
        underLine.frame.size.height = 2
        underLine.center.x = leftButton.center.x
        underLine.frame.origin.y = contentView.frame.size.height - underLine.frame.size.height
        
        //创建中间分割线
        let middleLine = UIView()
        middleLine.backgroundColor = UIColor.lightGrayColor()
        middleLine.frame.size.width = 1
        middleLine.frame.size.height = 15
        middleLine.frame.origin.x = contentView.frame.size.width * 0.5
        middleLine.frame.origin.y = 15
        middleLine.alpha = 0.7
        

        //添加按钮
        contentView.addSubview(leftButton)
        contentView.addSubview(rightButton)
        
        //添加下划线
        contentView.addSubview(underLine)
        
        //添加分割线
        contentView.addSubview(middleLine)
        
        
        self.navigationItem.titleView = contentView
        
    }
    
    //MARK:- 清单点击
    func clickLeft() {
        print("点击清单")
        rightButton.selected = false
        leftButton.selected = true
        
        //下划线动画
        UIView.animateWithDuration(0.25) { 
            self.underLine.center.x = self.leftButton.center.x
        }
        
        //添加右侧创建按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "discover_write_article_icon_18x20_"), highlightImage: UIImage(named: "discover_write_article_highlisht_icon_19x20_"), target: self, action: #selector(BTDiscoverViewController.creatText))
    }
    
    //MARK:- 单品点击
    func clickRight() {
        print("点击单品")
        leftButton.selected = false
        rightButton.selected = true
        
        //下划线动画
        UIView.animateWithDuration(0.25) {
            self.underLine.center.x = self.rightButton.center.x
        }
        
        //加载照相按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "discovey_camera_btn_24x19_"), highlightImage: UIImage(named: ""), target: self, action: #selector(BTDiscoverViewController.photoClick))
    }
    
    //MARK:- photo点击
    func photoClick() {
        print("点击照片")
    }
    
}
