//
//  BTHomePageDataTool.swift
//  BanTang
//
//  Created by 张灿 on 16/6/6.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit
import MJExtension
import AFNetworking

var kBaseUrl = "http://open3.bantangapp.com/"

class BTHomePageDataTool: NSObject {
    
    //获取轮播图url字符串数组
    class func getBannerArray(result: (bannerArray: [String]?) -> ()) {
        let url: String = kBaseUrl + "recommend/index?"
        let parmas: NSMutableDictionary = BTBaseRequestParmas.parmas().mj_keyValues()
        parmas["page"] = 0
        
        let manager = AFHTTPSessionManager()
        
        
        manager.GET(url, parameters: parmas, progress: nil, success: { (_, jsonData) in
            //将AnyObject转化成字典类型
            guard (jsonData as? [String : NSObject]) != nil else {
                return
            }
            
            
            
            let data: BTHomePageData = BTHomePageData.mj_objectWithKeyValues(jsonData!["data"])
            
            let banners: [BTHomeBanner] = data.banner
            
            var muarray: [String] = [String]()
            
            for banner in banners {
                muarray.append(banner.photo)
            }
            
            result(bannerArray: muarray)

            
            
            }) { (_, error) in
                
        }
        
    }
    
    //根据page获取cell数据 返回cell的模型数组
    class func getCellData(page: NSInteger, result: (homeTopicItems: [BTHomeTopic]?) -> ()) {
        let url: String = kBaseUrl + "recommend/index?"
        let parmas: NSMutableDictionary = BTBaseRequestParmas.parmas().mj_keyValues()
        parmas["page"] = page
        
        let manager = AFHTTPSessionManager()
        manager.GET(url, parameters: parmas, progress: nil, success: { (_, jsonData) in
            
            //将AnyObject转化成字典类型
            guard (jsonData as? [String : NSObject]) != nil else {
                return
            }
            let data: BTHomePageData = BTHomePageData.mj_objectWithKeyValues(jsonData!["data"])
            
            result(homeTopicItems: data.topic)
            
            }) { (_, error) in
                
                
        }
        
        
    }
    
    //根据id获取详情页数据
    class func getTopicData(infoId: String!, resultCallBack: (productModel: BTProductModel?, error: NSError?) -> ()) {
        
        let parmas: NSMutableDictionary = BTBaseRequestParmas.parmas().mj_keyValues()
        parmas["id"] = infoId
        parmas["statistics_uv"] = 0
        parmas.removeObjectForKey("pagesize")
        let url: String = kBaseUrl + "topic/newInfo?"
        let manager = AFHTTPSessionManager()
        manager.GET(url, parameters: parmas, progress: nil, success: { (_, jsonData) in
            
            //将AnyObject转化成字典类型
            guard (jsonData as? [String : NSObject]) != nil else {
                return
            }
            
            let data: BTProductModel = BTProductModel.mj_objectWithKeyValues(jsonData!["data"])
            
            resultCallBack(productModel: data, error: nil)
            
            }) { (_, error) in
            resultCallBack(productModel: nil, error: error)
        }
        
        
    }

}
