//
//  BTHomeTopic.swift
//  BanTang
//
//  Created by 张灿 on 16/6/6.
//  Copyright © 2016年 张灿. All rights reserved.
//


import UIKit

class BTHomeTopic:  NSObject {
    
    /** 标题 */
    var title: String = ""
    
    /** 类型 */
    var type: String = ""
    
    /** 图片 */
    var pic: String  = ""
    
    /** 是否显示喜欢 */
    var is_show_like: Bool = false
    
    /** 是否喜欢 */
    var islike:Bool = false
    
    /** 喜欢的人数 */
    var likes: String = ""
    
    /** 用户模型 */
    var user : BTTopicUserItem?
}
