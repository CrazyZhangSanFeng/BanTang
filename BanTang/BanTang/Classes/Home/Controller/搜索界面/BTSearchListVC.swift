//
//  BTSearchListVC.swift
//  BanTang
//
//  Created by 张灿 on 16/6/20.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit

private let cellID = "BTSearchListCell"

class BTSearchListVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var collectionView: UICollectionView?
    
    //模型数组
    var listModels: [BTSearchListModel] = [BTSearchListModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildCollectionView()
        
        loadData()

    }
    
    func buildCollectionView() {
        //布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: BTscreenW / 3, height: (BTscreenH - 64 - 44) / 3.5)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .Vertical
        
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView!.backgroundColor = UIColor.whiteColor()
        
        collectionView!.dataSource = self
        collectionView!.delegate = self
        
        //注册cell
        collectionView!.registerNib(UINib.init(nibName: "BTSearchListCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        view.addSubview(collectionView!)
        
        //约束
        collectionView!.snp_makeConstraints { (make) in
            
            make.top.trailing.leading.bottom.equalTo(self.view)
            
        }

        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return listModels.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! BTSearchListCell
        
        cell.listModel = listModels[indexPath.row]
        
        return cell
        
    }
    
    // MARK: - 加载数据
    func loadData() {
        BTHomePageDataTool.getSearchListData { (listModels, error) in
            
            if error != nil {
                return
            }
            
            self.listModels = listModels!
            
            self.collectionView?.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
