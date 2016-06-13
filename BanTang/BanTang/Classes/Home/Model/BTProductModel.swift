//
//  BTProductModel.swift
//  BanTang
//
//  Created by 张灿 on 16/6/9.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit
import MJExtension

//MARK:- 头部详情模型
class BTProductModel: NSObject {
    /** 图片 */
    var pic: String = ""
    /** 标题 */
    var title: String = ""
    /** 内容 */
    var desc: String = ""
    /** 是否喜欢 */
    var islike: Bool = false
    /** 分享链接 */
    var share_url: String = ""
    /** 分享图片 */
    var share_pic: String = ""
    /** id */
    var ID: String = ""
    
    var product_pic_host: String = ""
    
    var user_avatr_host: String = ""
    
    /** 内容数组 */
    var product: [ProductDetail] = [ProductDetail]()
    
    override static func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
        return ["ID": "id"]
    }
    
    override static func mj_objectClassInArray() -> [NSObject : AnyObject]! {
        return ["product": ProductDetail.classForCoder()]
    }

}

//MARK:- cell详情模型
class ProductDetail: NSObject {
    /** id */
    var pid: String = ""
    /** 标题 */
    var title: String = ""
    /** 内容 */
    var desc: String = ""
    /** 是否喜欢 */
    var islike: Bool = false
    /** 价格 */
    var price: String = ""
    
    /** 淘宝之类的链接 */
    var url: String = ""
    /** 评论数 */
    var comments: String = ""
    /** 喜欢数 */
    var likes: String = ""
    
    /** 喜欢的用户数组 */
    var likes_list: [LikeModel] = [LikeModel]()
    
    /** 图片数组 */
    var pic: [PicModel] = [PicModel]()
    
    override static func mj_objectClassInArray() -> [NSObject : AnyObject]! {
        return ["likes_list": LikeModel.classForCoder(), "pic": PicModel.classForCoder()]
    }
    
}

//MARK:- 喜欢列表模型
class LikeModel: NSObject {
    var u: String = ""
    var a: String = ""
}

//MARK:- 图片模型
class PicModel: NSObject {
    var p: String = ""
    var w: String = ""
    var h: String = ""
}
