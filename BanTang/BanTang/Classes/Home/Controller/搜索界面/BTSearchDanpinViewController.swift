//
//  BTSearchDanpinViewController.swift
//  BanTang
//
//  Created by 张灿 on 16/6/20.
//  Copyright © 2016年 张灿. All rights reserved.
// 搜索界面里的 单品控制器 

import UIKit
import SnapKit

private let cellID = "danpinSearchTableCell"
private let collectionCellID = "collectionCellID"

class BTSearchDanpinViewController: UIViewController {
    
    //左侧模型数组
    var danPinModels: [BTSearchDanpinModel] = [BTSearchDanpinModel]()
    
    //左侧cell选中时 对应的 右侧模型数组
    var selectModels: [subclassModel] = [subclassModel]()
    
    //左侧tableview
    var danPinTableView: UITableView?
    
    //右侧collectionView
    var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildtableView()
        
        buildCollectionView()
        
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
//MARK: - 创建左侧tableview
extension BTSearchDanpinViewController: UITableViewDelegate, UITableViewDataSource {
    
    func buildtableView() {
        //创建tableview
        danPinTableView = UITableView(frame: CGRectZero, style: .Plain)
        danPinTableView!.dataSource = self
        danPinTableView!.delegate = self
        //取消系统分割线
        danPinTableView!.separatorStyle = .None
        danPinTableView!.backgroundColor = UIColor(red: 240 / 255.0, green: 240 / 255.0, blue: 240 / 255.0, alpha: 1.0)
        danPinTableView!.rowHeight = 50
        danPinTableView!.showsVerticalScrollIndicator = false
        
        //注册cell
        danPinTableView!.registerNib(UINib.init(nibName: "BTSearchCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
        
        view.addSubview(danPinTableView!)
        
        danPinTableView!.snp_makeConstraints { (make) in
            make.top.leading.bottom.equalTo(self.view)
            make.width.equalTo(BTscreenW / 4)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return danPinModels.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID) as! BTSearchCategoryTableViewCell
        
        cell.categoryModel = danPinModels[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //把当前选中cell的模型里面的右侧模型数组拿出来,保存起来
        selectModels = danPinModels[indexPath.row].subclass
        
        //刷新右侧
        collectionView?.reloadData()
        
    }
}

//MARK: - 创建右侧collectionview
extension BTSearchDanpinViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func buildCollectionView() {
        
        let margin: CGFloat = 0
        
        //布局方式
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin
        layout.itemSize = CGSize(width: BTscreenW / 4 * 3 / 3, height: 100)
        layout.scrollDirection = .Vertical
        
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView!.backgroundColor = UIColor.whiteColor()
        
        collectionView!.dataSource = self
        collectionView!.delegate = self
        
        //注册cell
        collectionView!.registerNib(UINib.init(nibName: "BTSearchCategoryRightCell", bundle: nil), forCellWithReuseIdentifier: collectionCellID)
        view.addSubview(collectionView!)
        
        collectionView!.snp_makeConstraints { (make) in
            make.top.trailing.bottom.equalTo(self.view)
            make.leading.equalTo((self.danPinTableView?.snp_trailing)!)
        }
        
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return selectModels.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(collectionCellID, forIndexPath: indexPath) as! BTSearchCategoryRightCell
        
        cell.subclass = selectModels[indexPath.row]
        
        return cell
        
    }
    
}

//MARK: - 数据请求
extension BTSearchDanpinViewController {
    
    func loadData() {
        BTHomePageDataTool.getSearchDanpinData { (danpinModels, error) in
            if error != nil {
                return
            }
            self.danPinModels = danpinModels!

            //默认加载右侧第一个
            self.selectModels = self.danPinModels[0].subclass
            
            self.danPinTableView?.reloadData()
            
            self.collectionView?.reloadData()
            
            //默认选中第一个cell,注意!!!一定要在刷新之后做!
            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            
            self.danPinTableView?.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: .None)
            
            //点用代理,选中cell,请求数据
            self.tableView(self.danPinTableView!, didSelectRowAtIndexPath: indexPath)
            
        }
    }
}
