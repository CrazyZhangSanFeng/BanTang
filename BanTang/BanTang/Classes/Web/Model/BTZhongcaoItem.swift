//
//  BTZhongcaoItem.swift
//  BanTang
//
//  Created by 张灿 on 16/6/19.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit
import MJExtension

class BTZhongcaoItem: NSObject {
    
    /** 标题 */
    var name: String = ""
    
    /** 图片 */
    var pic2: String = ""
    
    var dynamic: dynamicItem?
    

}

class dynamicItem: NSObject {
    /** 浏览量 */
    var views: String = ""
    
    /** 帖子量 */
    var posts: String = ""
}
