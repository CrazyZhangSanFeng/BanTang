//
//  BTHotView.swift
//  BanTang
//
//  Created by 张灿 on 16/5/29.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit
import AFNetworking
import MJExtension

protocol BTHotViewDelegate: class {
    func BTHotViewLastCellWillAppear()
}


//列
private let cols: CGFloat = 3
//间距
private let margin: CGFloat = 2
private let wh = (UIScreen.mainScreen().bounds.width - (cols - 1) * margin) / cols
private let footCellID = "footCellID"

class BTHotView: UIView {

    @IBOutlet weak var collectionV: UICollectionView!
    
    weak var delegate: BTHotViewDelegate?
    
    var hotItems: [BTHotItem]? {
        didSet {
            guard hotItems != nil else {
                return
            }
            //重新设置collectionView高度
//            let maxRows = (hotItems.count - 1) / 3 + 1
//            let h: CGFloat = CGFloat(maxRows) * wh + CGFloat(maxRows) * margin
//            
//            self.collectionV?.frame.size.height = h
//            
//            print("有计算了一遍collectionview高度")
            
            self.collectionV.reloadData()
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setCollectionView()
        
    }
    

}

extension BTHotView {
    func setCollectionView() {
        //创建布局
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: wh, height: wh)
        
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin
        
        collectionV.collectionViewLayout = layout
        
        //注册cell
        collectionV.registerNib(UINib.init(nibName: "BTHotCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: footCellID)
        
        collectionV.backgroundColor = UIColor.whiteColor()
        collectionV.dataSource = self
        collectionV.delegate = self
        
        //取消多余的scrollsToTop,使得只有一个tableView拥有触顶返回功能
        collectionV.scrollsToTop = false
    }
}

extension BTHotView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hotItems?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(footCellID, forIndexPath: indexPath) as! BTHotCollectionViewCell
        
        if hotItems?.count > 0 {
            
            cell.hotItem = hotItems![indexPath.row]
        }
        
         //判断是否是最后一个cell即将出现
        if indexPath.row == hotItems!.count - 1 {
            
            //发送通知给单品控制器,让他去加载更多数据
//            NSNotificationCenter.defaultCenter().postNotificationName("reloadHotData", object: self)
//            self.delegate?.BTHotViewLastCellWillAppear()
//            print("发送了通知")
        }
        
        return cell
    }

    
}
