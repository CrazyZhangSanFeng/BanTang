//
//  BTHomePageData.swift
//  BanTang
//
//  Created by 张灿 on 16/6/6.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit
import MJExtension

class BTHomePageData: NSObject {
    
    /**最新*/
    var topic: [BTHomeTopic] = [BTHomeTopic]()
    
    /**轮播*/
    var banner: [BTHomeBanner] = [BTHomeBanner]()
    
    /**标题*/
    var category_element: [BTCategoryElement] = [BTCategoryElement]()
    
    override static func mj_objectClassInArray() -> [NSObject : AnyObject]! {
        return ["topic" : BTHomeTopic.classForCoder(),
                "banner" : BTHomeBanner.classForCoder(),
                "category_element" : BTCategoryElement.classForCoder()
        ]
    }
    
}
