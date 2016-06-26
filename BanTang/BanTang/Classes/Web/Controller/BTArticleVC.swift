//
//  BTArticleVC.swift
//  BanTang
//
//  Created by 张灿 on 16/6/25.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit

class BTArticleVC: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var loadingView: BTLoadingView?
    
    //模型
    var articleModel: BTArticleModel? {
        didSet {
            guard let articleModel = articleModel else {
                return
            }
            webView.loadHTMLString(articleModel.article_content, baseURL: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //加载动画
        loadingView = BTLoadingView.shareInstance.loadingViewToView(self.view) as? BTLoadingView
        loadingView?.startAnimation()
        loadingView?.center.x = BTscreenW * 0.5
        loadingView?.center.y = BTscreenH * 0.5
        view.addSubview(loadingView!)
        
        loadData()
    }
    
    //加载数据
    func loadData() {
        BTHomePageDataTool.getArticalData { (listModel, error) in
            if error == nil {
                self.loadingView?.hideAnimation()
                self.articleModel = listModel
            } else {
                self.loadingView?.hideAnimation()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
