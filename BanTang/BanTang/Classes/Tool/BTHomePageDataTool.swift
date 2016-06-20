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
    
    //获取种草小分队数据 返回一个模型数组
    class func getZhongcaoQueueData(resultCallBack: (zhongcaoItems: [BTZhongcaoItem]?, error: NSError?) -> ()) {
        
        let parmas: NSMutableDictionary = BTBaseRequestParmas.parmas().mj_keyValues()
        parmas.removeObjectForKey("page")
        parmas.removeObjectForKey("pagesize")
        let url = kBaseUrl + "community/post/communityHome?"
        let manager = AFHTTPSessionManager()
        manager.GET(url, parameters: parmas, progress: nil, success: { (_, jsonData) in
            
            //将AnyObject转化成字典类型
            guard (jsonData as? [String : NSObject]) != nil else {
                return
            }
            
            let data = jsonData!["data"] as! [String: NSObject]
            
            //获取字典数组
            let rec_groups = data["rec_groups"] as! [[String: NSObject]]
            
            //字典数组转模型数组
            let zhongcaos = BTZhongcaoItem.mj_objectArrayWithKeyValuesArray(rec_groups)
            
            var itemArr: [BTZhongcaoItem] = [BTZhongcaoItem]()
            
            for zhaongcaoItem in zhongcaos {
                
                itemArr.append(zhaongcaoItem as! BTZhongcaoItem)
            }
            
            resultCallBack(zhongcaoItems: itemArr, error: nil)
            
            }) { (_, error) in
                //错误回调
                resultCallBack(zhongcaoItems: nil, error: error)
        }
        
        
    }
    
    /** 获取搜索界面单品数据 */
    class func getSearchDanpinData(resultCallBack: (danpinModels: [BTSearchDanpinModel]?, error: NSError?) -> ()) {
        let parmas: NSMutableDictionary = BTBaseRequestParmas.parmas().mj_keyValues()
        parmas.removeObjectForKey("page")
        parmas.removeObjectForKey("pagesize")
        parmas.removeObjectForKey("last_get_time")
        parmas["is_new"] = 1
        let url = kBaseUrl + "category/list"
        let manager = AFHTTPSessionManager()
        
        manager.POST(url, parameters: parmas, progress: nil, success: { (_, jsonData) in
            
            //将AnyObject转化成字典类型
            guard (jsonData as? [String : NSObject]) != nil else {
                return
            }
            
            //字典数组 转 模型数组
            let data = BTSearchDanpinModel.mj_objectArrayWithKeyValuesArray(jsonData!["data"])
            
            var itemArr: [BTSearchDanpinModel] = [BTSearchDanpinModel]()
            
            //将所有子元素 转换成 模型类型
            for danpinModel in data {
                
                itemArr.append(danpinModel as! BTSearchDanpinModel)
            }
            
            //成功回调
            resultCallBack(danpinModels: itemArr, error: nil)
            
            
            }) { (_, error) in
                //错误回调
                resultCallBack(danpinModels: nil, error: error)
        }
        
    }
    
    /** 获取搜索界面 清单 数据 */
    class func getSearchListData(resultCallBack: (listModels: [BTSearchListModel]?, error: NSError?) -> ()) {
        
        let parmas: NSMutableDictionary = BTBaseRequestParmas.parmas().mj_keyValues()
        parmas.removeObjectForKey("page")
        parmas.removeObjectForKey("pagesize")
        parmas.removeObjectForKey("last_get_time")
        let url = kBaseUrl + "category/scene"
        let manager = AFHTTPSessionManager()
        
        manager.POST(url, parameters: parmas, progress: nil, success: { (_, jsonData) in
            
            //将AnyObject转化成字典类型
            guard (jsonData as? [String : NSObject]) != nil else {
                return
            }
            
            //字典数组 转 模型数组
            let data = BTSearchListModel.mj_objectArrayWithKeyValuesArray(jsonData!["data"])
            
            var itemArr: [BTSearchListModel] = [BTSearchListModel]()
            
            //将所有子元素 转换成 模型类型
            for listModel in data {
                
                itemArr.append(listModel as! BTSearchListModel)
            }
            
            //成功回调
            resultCallBack(listModels: itemArr, error: nil)
            
            }) { (_, error) in
                
                //错误回调
                resultCallBack(listModels: nil, error: error)
        }
        
    }

}
