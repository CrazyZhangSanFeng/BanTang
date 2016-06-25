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
    
    //发现界面文章cell详情内容   死数据
    class func getArticalData(resultCallBack: (listModel: BTArticleModel?, error: NSError?) -> ()) {

        let url = "http://open3.bantangapp.com/topic/newInfo?app_id=com.jzyd.BanTang&app_installtime=1463934108&app_versions=5.8.2&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&id=4858&is_night=0&oauth_token=1e4dd1de95a179d017efa7502fd6515a&os_versions=9.3.2&screensize=640&statistics_uv=0&track_device_info=iPhone6%2C2&track_deviceid=EAC59F1B-C110-48FA-B013-02A92744278A&track_user_id=2182968&type_id=1&v=14"
        let manager = AFHTTPSessionManager()
        
        manager.GET(url, parameters: nil, progress: nil, success: { (_, jsonData) in
            //将AnyObject转化成字典类型
            guard (jsonData as? [String : NSObject]) != nil else {
                return
            }
            
            let data: BTArticleModel = BTArticleModel.mj_objectWithKeyValues(jsonData!["data"])
            
            resultCallBack(listModel: data, error: nil)
            
            
            }) { (_, error) in
                resultCallBack(listModel: nil, error: error)
        }
        
    }

}
