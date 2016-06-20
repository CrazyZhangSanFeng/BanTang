//
//  BTSearchDanpinModel.swift
//  BanTang
//
//  Created by 张灿 on 16/6/20.
//  Copyright © 2016年 张灿. All rights reserved.
// "搜索界面" 的 "单品" 列表 数据模型

import UIKit
import MJExtension

class BTSearchDanpinModel: NSObject {
    /** 标题 */
    var name: String = ""
    
    /** subclassModel模型数组 */
    var subclass: [subclassModel] = [subclassModel]()
    
    //数组中需要转换的模型
    override static func mj_objectClassInArray() -> [NSObject : AnyObject]! {
        return ["subclass": subclassModel.classForCoder()]
    }
    
}

class subclassModel: NSObject {
    /** 图片 */
    var icon: String = ""
    
    /** 标题 */
    var name: String = ""
    
}