//
//  BTNewController.swift
//  BanTang
//
//  Created by 张灿 on 16/6/2.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit

class BTNewController: BTBaseTVC {
    
    var page: NSInteger = 0
    
    //模型数组
    var homeTopicItems: [BTHomeTopic] = [BTHomeTopic]() {
        didSet {

            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData(page)

    }
    
    //加载数据
    func loadData(page: NSInteger) {
        //获取数据
        BTHomePageDataTool.getCellData(page, result: { (homeTopicItems) in
            
            if homeTopicItems != nil {
                
                for item in homeTopicItems! {
                    self.homeTopicItems.append(item)
                }
                
            }
        })
    }


    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return homeTopicItems.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = BTHomeTopicCell.cellWithTableView(tableView)
        
        cell.homeTopicItem = homeTopicItems[indexPath.row]
        cell.selectionStyle = .None
        
        if indexPath.row == homeTopicItems.count - 1 {
            page += 1
            loadData(page)
        }
        
        return cell
    }
    
    //MARK: - 点击跳转
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let vc = BTProductDetailVC()
        vc.extenID = "\(homeTopicItems[indexPath.row].ID)"
        navigationController?.pushViewController(vc, animated: true)
    }

}
