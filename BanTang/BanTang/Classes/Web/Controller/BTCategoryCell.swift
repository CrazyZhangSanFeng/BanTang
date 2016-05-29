//
//  BTCategoryCell.swift
//  BanTang
//
//  Created by 张灿 on 16/5/27.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit
import MJExtension
import AFNetworking
import SDWebImage

private let listUrlStr = "http://open3.bantangapp.com/community/post/index?app_id=com.jzyd.BanTang&app_installtime=1463934108&app_versions=5.8&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&oauth_token=f1d476369a332f4e16f578a6228bd97e&os_versions=9.3.2&screensize=640&track_device_info=iPhone6%2C2&track_deviceid=EAC59F1B-C110-48FA-B013-02A92744278A&track_user_id=2182968&v=13"

class BTCategoryCell: UITableViewCell {

    
    @IBOutlet weak var scrollerView: UIScrollView!
    
    @IBOutlet weak var page: UIPageControl!
    
    var imageview = UIImageView()
    
    //用来存放创建的分类按钮
    var buttons = [UIButton]()
    
    //模型数组
    var categoryItems: NSMutableArray!
    
    
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        loadDanpinData()
        
        scrollerView.pagingEnabled = true
        scrollerView.showsHorizontalScrollIndicator = false
        //取消多余的scrollsToTop,使得只有一个tableView拥有触顶返回功能
        scrollerView.scrollsToTop = false
        
        
    }

}

//MARK:- 设置分类scrollerView
extension BTCategoryCell {
    func setCategory(count : NSInteger) {
        
        //设置2列
        let maxCols: NSInteger = 2
        
        //设置间距
        let margin: CGFloat = 10
        
        //设置按钮的宽高,还有坐标
        let W: CGFloat = (UIScreen.mainScreen().bounds.size.width - CGFloat(maxCols + 1) * margin) / CGFloat(maxCols)
        let H: CGFloat = 90
        var X: CGFloat = 0
        var Y: CGFloat = 0
        
        for i in 0 ..< count {
            //行序列号
            let row: NSInteger = i / maxCols
            //列序列号
            let col: NSInteger = i % maxCols
            let button: UIButton
            if row >= 3 {
                X = W * CGFloat(col + 2) + CGFloat(col + 4) * margin
                Y = H * CGFloat(row - 3) + CGFloat(row - 2) * margin
                //创建按钮
                button = UIButton(type: .Custom)
                
                button.tag = i
                
                button.frame = CGRect(x: X, y: Y, width: W, height: H)
                
                
                //按钮圆角
                button.layer.cornerRadius = 3
                button.layer.masksToBounds = true
                
                scrollerView.addSubview(button)
                
                scrollerView.contentSize = CGSize(width: 2 * UIScreen.mainScreen().bounds.width, height: 317)
                buttons.append(button)
            } else{
                
                //设置商品的坐标
                X = W * CGFloat(col) + CGFloat(col + 1) * margin
                Y = H * CGFloat(row) + CGFloat(row + 1) * margin
                
                //创建按钮
                button = UIButton(type: .Custom)
                
                button.tag = i
                
                button.frame = CGRect(x: X, y: Y, width: W, height: H)
                
                //按钮圆角
                button.layer.cornerRadius = 3
                button.layer.masksToBounds = true
                
                scrollerView.addSubview(button)
                
                scrollerView.contentSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: 317)
                buttons.append(button)
            }
            
        }
    }

}

//MARK:- scrollerView代理 分页设置
extension BTCategoryCell: UIScrollViewDelegate{
    //设置当前显示页的小圆点
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let pageNumber = NSInteger(self.scrollerView.contentOffset.x / self.scrollerView.frame.size.width)
        
        page.currentPage = pageNumber
    }
    
}

//MARK:- 请求数据
extension BTCategoryCell {
    func loadDanpinData() {
        //创建会话管理者
        let manager = AFHTTPSessionManager()
        
        manager.GET(listUrlStr, parameters: nil, progress: nil, success: { (_, response) in

            guard (response as? [String : NSObject]) != nil else {
                return
            }
            let dataDict = response!["data"] as? [String : NSObject]
            let category_listArray = dataDict!["category_list"] as? [[String : NSObject]]
                    
            self.categoryItems = BTCategoryItem.mj_objectArrayWithKeyValuesArray(category_listArray)
            
            //设置按钮
            self.setCategory(self.categoryItems.count)
            
            //给按钮加载图片
//            let btns = self.buttons.map{$0 as UIButton}
//            for i in 0..<btns.count{
//                let btn = btns[i]
//                let item = (self.categoryItems.map{ $0 as! BTCategoryItem})[i]
//                btn.sd_setImageWithURL(NSURL(string: item.pic)!, forState: .Normal, placeholderImage: UIImage(named: "default_user_icon_75x75_"))
//            }
            
//            let btns = self.buttons.map{$0 as UIButton}
            for i in 0..<self.buttons.count{
                let btn = self.buttons[i]
                let item = (self.categoryItems.map{ $0 as! BTCategoryItem})[i]
                btn.sd_setImageWithURL(NSURL(string: item.pic)!, forState: .Normal, placeholderImage: UIImage(named: "default_user_icon_75x75_"))
            }
            
            
            
        }) { (_, error) in
            
        }
        
    }

}




