//
//  BTProductDetailVC.swift
//  BanTang
//
//  Created by 张灿 on 16/6/9.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit
import SnapKit

/** 顶部图片高 */
private let topImageH: CGFloat = 0.55 * UIScreen.mainScreen().bounds.width

/** 标题高度 */
private let titleH: CGFloat = 44

private let CustomBarTintColor = "ec5252"

private let cellID = "productCell"
class BTProductDetailVC: UIViewController, UINavigationControllerDelegate {
    
    var titlelabel: UILabel?
    
    var extenID: String?
    //顶部图片
    var topImageView: UIImageView?
    
    //顶部图片在首页的frame
    var topImageViewFrameInHomeView: CGRect?
    
    var tableView: UITableView?
    
    /** 悬停标题 */
    var titleView: BTTitleView?
    
    /** 模型 */
    var productModel: BTProductModel? {
        didSet {
            guard let productModel = productModel else {
                return
            }
                
            topImageView?.sd_setImageWithURL(NSURL(string: productModel.pic))

        }
    }
    
    /** 用户推荐 */
//    var userRecomendList: [UserRecomend] = [UserRecomend]()
    var isUserRecomend: Bool = false
    
    /** 导航栏透明值 */
    var navigationBarAlpha: CGFloat?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        navigationController?.delegate = self
        
        buildNavigationBar()
        buildTopImageView()
        
        loadTopicData()
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBar.setBackgroundImage(UIImage(color: UIColor(white: 1.0, alpha: 0.0)), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        titlelabel!.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
}
//MARK:- 设置导航栏
extension BTProductDetailVC {
    func buildNavigationBar() {
        
        automaticallyAdjustsScrollViewInsets = false
        let favItem = UIBarButtonItem(image: UIImage(named: "btn_topic_collect_white_21x20_"), selImage: UIImage(named: "btn_topic_collect_yellow_21x20_"), target: self, action: #selector(favBtnClick(_:)))
        
        let shareItem = UIBarButtonItem(image: UIImage(named: "btn_topic_share_white_24x18_"), highlightImage: nil, target: self, action: #selector(shareBtnClick(_:)))
        
        navigationItem.rightBarButtonItems = [shareItem, favItem]
        
        //导航栏标题
        titlelabel = UILabel()
        titlelabel!.text = "购物清单"
        titlelabel!.textColor = UIColor.darkGrayColor()
        titlelabel!.sizeToFit()
        navigationItem.titleView = titlelabel
        
        
    }
    
    func favBtnClick(btn: UIButton) {
        
    }
    
    func shareBtnClick(btn: UIButton) {
        //遮盖
        let cover = BTCoverView.show()
        //分享
        let shareV = BTShareView.shareView()
        shareV.frame.size.width = BTscreenW
        
        weak var weakself: BTCoverView? = cover
        
        //点击屏幕,做动画并且移除遮盖
        cover.click = {
            
            UIView.animateWithDuration(0.25, animations: { 
                shareV.frame.origin.y = BTscreenH
                }, completion: { (_) in
                 shareV.removeFromSuperview()
                 weakself!.removeFromSuperview()
            })
            
        }
        
    }
}

//MARK:- 设置顶部图片
extension BTProductDetailVC {
    
    func buildTopImageView() {
        
        topImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: BTscreenW, height: topImageH))
        view.addSubview(topImageView!)
    }
}

//MARK:- 加载数据
extension BTProductDetailVC {
    func loadTopicData() {
        
        //加载动画
        
        //请求数据
        BTHomePageDataTool.getTopicData(extenID) { (productModel, error) in
            if error == nil {
                self.productModel = productModel
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (__int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), {
                    //取消加载动画
                    
                    //布局tableview
                    self.buildTableView()
                    self.tableView?.layoutIfNeeded()
                    self.tableView?.snp_updateConstraints(closure: { (make) in
                        make.top.equalTo(self.view).offset(64)
                    })
                    self.tableView?.setNeedsLayout()
                    UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .CurveEaseOut, animations: {
                        self.tableView?.layoutIfNeeded()
                        }, completion: { (_) in
                            
                    })
                })
            }
        }
        //        [UserRecomendData loadUserRecomendData:^(id data, NSError *error) {
        //            self.userRecomendList = data;
        //            }];
    }

}


//MARK:- 设置tableView
extension BTProductDetailVC: UITableViewDelegate, UITableViewDataSource, BTTitleViewDelegate {
    func buildTableView(){
        tableView = UITableView()
        tableView?.delegate = self
        tableView?.dataSource = self
        //cell高度自适应
        tableView?.rowHeight = UITableViewAutomaticDimension
//        tableView?.estimatedRowHeight = isUserRecomend ? 1000 : 800
        if isUserRecomend {
            tableView?.estimatedRowHeight = 1000
        } else {
            tableView?.estimatedRowHeight = 800
        }
        tableView?.separatorStyle = .None
        tableView?.backgroundColor = UIColor.clearColor()
        view.addSubview(tableView!)
        tableView?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(view).offset(64 + 500)
            make.leading.trailing.bottom.equalTo(view)
        })
        
        //创建头部视图
        let headerView = UIView()
        //导航栏底部的透明视图
        let clearView = UIView()
        clearView.backgroundColor = UIColor.clearColor()
        clearView.frame = CGRect(x: 0, y: 0, width: BTscreenW, height: topImageH - 64)
        headerView.addSubview(clearView)
        let topicDesView = BTTopicDesView()
        topicDesView.backgroundColor = UIColor.whiteColor()
        let topicDesViewH: CGFloat = topicDesView.viewHeight(productModel!)
        topicDesView.frame = CGRect(x: 0, y: topImageH - 64, width: BTscreenW, height: topicDesViewH)
        headerView.addSubview(topicDesView)
        
        //悬停标题
        titleView = BTTitleView()
        titleView!.titleArray = ["半糖精选", "用户推荐"]
        titleView?.backgroundColor = UIColor.whiteColor()
        titleView!.delegate = self
        titleView!.frame = CGRect(x: 0, y: CGRectGetMaxY(topicDesView.frame), width: BTscreenW, height: titleH)
        headerView.addSubview(titleView!)
        headerView.frame = CGRect(x: 0, y: 0, width: BTscreenW, height: CGRectGetMaxY(titleView!.frame))
        tableView?.tableHeaderView = headerView
        
    }
    
    //tableview 数据源
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isUserRecomend {
//            return userRecomendList.count
        }
        
        return (productModel?.product.count)!
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if isUserRecomend {
            //            let cell = UserRecomendCell.cellWithTableView
        }
        let cell = BTProductCell.cellWithTableView(tableView)
        
        cell.userAvatrHost = productModel?.user_avatr_host
        cell.productPicHost = productModel?.product_pic_host
        cell.tag = indexPath.row
        
        cell.detailModel = productModel?.product[indexPath.row]

        
        return cell
    }
    

    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var alpha = scrollView.contentOffset.y / 250
        
        //导航条透明业务逻辑
        if alpha >= 1 {
            alpha = 0.99
            automaticallyAdjustsScrollViewInsets = false
            let favItem = UIBarButtonItem(image: UIImage(named: "btn_topic_collect_gray_21x20_"), selImage: UIImage(named: "btn_topic_collect_yellow_21x20_"), target: self, action: #selector(favBtnClick(_:)))
            
            let shareItem = UIBarButtonItem(image: UIImage(named: "btn_topic_share_gray_24x18_"), highlightImage: nil, target: self, action: #selector(shareBtnClick(_:)))
            
            navigationItem.rightBarButtonItems = [shareItem, favItem]
        } else {
            automaticallyAdjustsScrollViewInsets = false
            let favItem = UIBarButtonItem(image: UIImage(named: "btn_topic_collect_white_21x20_"), selImage: UIImage(named: "btn_topic_collect_yellow_21x20_"), target: self, action: #selector(favBtnClick(_:)))
            
            let shareItem = UIBarButtonItem(image: UIImage(named: "btn_topic_share_white_24x18_"), highlightImage: nil, target: self, action: #selector(shareBtnClick(_:)))
            
            navigationItem.rightBarButtonItems = [shareItem, favItem]
        }
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(color: UIColor(white: 1.0, alpha: alpha)), forBarMetrics: .Default)
        
        //导航条标题业务逻辑
        if alpha == 0.0 {
            titlelabel?.hidden = true
            
        }else {
            titlelabel?.hidden = false
            titlelabel?.alpha = alpha
        }
        
        //顶部图片的缩放
        if scrollView.contentOffset.y < 0 {
            let bigImageH = topImageH + fabs(scrollView.contentOffset.y)
            let scale = bigImageH / topImageH
            topImageView?.frame = CGRect(x: -(BTscreenW * scale - BTscreenW) * 0.5, y: 0, width: BTscreenW * scale, height: bigImageH)
        } else {
            topImageView?.frame = CGRect(x: 0, y: -scrollView.contentOffset.y, width: CGRectGetWidth(topImageView!.frame), height: CGRectGetHeight(topImageView!.frame))
        }
        
        let titleViewX = CGRectGetMaxY(tableView!.tableHeaderView!.frame) - titleH
        
        if scrollView.contentOffset.y > titleViewX {
            titleView?.frame = CGRect(x: 0, y: 64, width: BTscreenW, height: titleH)
            view.addSubview(titleView!)
        } else {
            titleView?.frame = CGRect(x: 0, y: titleViewX, width: BTscreenW, height: titleH)
            tableView?.tableHeaderView?.addSubview(titleView!)
        }
    }
    
    //标题按钮点击
    func titleView(titleView: BTTitleView, didClickBtnIndex btnIndex: NSInteger) {
        if btnIndex == 1 {
            isUserRecomend = false
        } else {
            isUserRecomend = true
        }
        //刷新第二个section
        let nd = NSIndexSet(index: 0)
        tableView?.reloadSections(nd, withRowAnimation: .Fade)
    }
}
