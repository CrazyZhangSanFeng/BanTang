//
//  BTSettingController.swift
//  BanTang
//
//  Created by 张灿 on 16/5/30.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit

class BTSettingController: UITableViewController {
    
  //清理缓存
    @IBOutlet weak var cleanLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //背景色即分割线颜色
        tableView.backgroundColor = UIColor(red: 244 / 255.0, green: 244 / 255.0, blue: 244 / 255.0, alpha: 1.0)
        tableView.sectionFooterHeight = 1
        
        cleanLabel.text = sizeString()
    }
    
//夜间模式
    @IBAction func nightClick(sender: UISwitch) {
        debugPrint("夜间模式")
    }

}

extension BTSettingController {
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       
        return 10
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.section,indexPath.row)
        if indexPath.section == 1 && indexPath.row == 2 {
            
            clean()
            cleanLabel.text = sizeString()
            
        }
    }
}

//清理缓存业务逻辑
extension BTSettingController {
    //拼接缓存大小
    func sizeString() -> String {
        //获取cache文件夹路径
        let cachePath: String = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true).first!
        
        //获取缓存大小
        let size: NSInteger = ZCFileManager.getSizeOfDirectoryPath(cachePath)
        
        var str: String = "0.00K"
        //判断尺寸大小,拼接不同显示方式
        if size > 1000 * 1000 {
            let sizeMB: CGFloat = CGFloat(size) / 1000.0 / 1000.0
            str = "\(String(format: "%.1f", sizeMB))MB"
        } else if size > 1000 {
            let sizeKB: CGFloat = CGFloat(size) / 1000.0
            str = "\(String(format: "%.1f", sizeKB))KB"
        } else if size > 0 {
            str = "\(size)dB"
        }
        
        return str
    }
    
    //清理缓存
    func clean() {
        //获取cachelujing
        let cachePath: String = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true).first!
        
        //清空缓存
        ZCFileManager.removeDirectoryPath(cachePath)

    }
}











