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

//private let listUrlStr = "http://open3.bantangapp.com/community/post/index?app_id=com.jzyd.BanTang&app_installtime=1463934108&app_versions=5.8&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&oauth_token=f1d476369a332f4e16f578a6228bd97e&os_versions=9.3.2&screensize=640&track_device_info=iPhone6%2C2&track_deviceid=EAC59F1B-C110-48FA-B013-02A92744278A&track_user_id=2182968&v=13"

class BTCategoryCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var page: UIPageControl!
    
    //模型数组懒加载
    lazy var categoryItems : [BTCategoryItem] = [BTCategoryItem]()
    
    
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupCollectionView()
        
    }

}

//MARK:- 设置collectionView
extension BTCategoryCell {
    func setupCollectionView() {
        //创建布局方式
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let margin: CGFloat = 10
        let cols: CGFloat = 2
        let w = (UIScreen.mainScreen().bounds.size.width - (cols + 1) * margin) / cols
        
        layout.itemSize = CGSize(width: w, height: 90)
        
        
        layout.scrollDirection = .Horizontal
        
        //设置组间距
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        
        
        collectionView.collectionViewLayout = layout
        
        //collectionView底部间距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 25, right: 0)
        collectionView.pagingEnabled = true
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.showsHorizontalScrollIndicator = false
        
        
        //注册cell
        collectionView.registerNib(UINib.init(nibName: "BTCategoryCollectionCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")
        
    }
}

//MARK:- collectionview数据源

extension BTCategoryCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 6
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("categoryCell", forIndexPath: indexPath) as! BTCategoryCollectionCell
        
//        if indexPath.section == 0 {
//            
//                
//        cell.categoryItem = categoryItems[0]
//            
//        }
//        let item = categoryItems[indexPath.item]
//        print(indexPath.item)
        print("\(self.categoryItems.count)Collectioncell")
        
        
        
        return cell
    }
    
    //设置当前显示页的小圆点
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let pageNumber = NSInteger(self.collectionView.contentOffset.x / self.collectionView.frame.size.width)
        
        page.currentPage = pageNumber
    }
    
}

//MARK:- 请求数据
//extension BTCategoryCell {
//    func loadDanpinData() {
//        //创建会话管理者
//        let manager = AFHTTPSessionManager()
//        
//        manager.GET(listUrlStr, parameters: nil, progress: nil, success: { (_, response) in
//
//            guard (response as? [String : NSObject]) != nil else {
//                return
//            }
//            let dataDict = response!["data"] as? [String : NSObject]
//            let category_listArray = dataDict!["category_list"] as? [[String : NSObject]]
//                    
//            self.categoryItems = BTCategoryItem.mj_objectArrayWithKeyValuesArray(category_listArray) as! [BTCategoryItem]
//                    
//            print("\(self.categoryItems.count)网络请求")
//            
//            self.collectionView.reloadData()
//                
//            
//            
//        }) { (_, error) in
//            
//        }
//        
//    }
//
//}


