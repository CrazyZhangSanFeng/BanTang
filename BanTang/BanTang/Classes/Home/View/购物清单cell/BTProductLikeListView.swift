//
//  BTProductLikeListView.swift
//  BanTang
//
//  Created by 张灿 on 16/6/11.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

//头像宽高
private let iconWH: CGFloat = 28

//箭头宽
private let arrowW: CGFloat = 28

//默认边距
private let margin: CGFloat = 10

class BTProductLikeListView: UIView {
    //头像前缀
    var userAvatrHost: String?
    
    //头像数组
    var imageViewArray: [UIImageView] = [UIImageView]()
    
    //喜欢人数
    var likeLabel: UILabel?
    
    //最大头像数量
    var maxNum: NSInteger = 0
    
    //模型
    var productDetailModel: ProductDetail? {
        didSet {
            guard let productDetailModel = productDetailModel else {
                return
            }
            likeLabel?.text = "\(productDetailModel.likes)人喜欢"
            var count: NSInteger = 0
            if productDetailModel.likes_list.count > maxNum {
                count = maxNum
            }else {
                count = productDetailModel.likes_list.count
            }
            for i in 0..<count {
                let imageV = imageViewArray[i]
                let imageName = userAvatrHost! + productDetailModel.likes_list[i].a
                imageV.sd_setImageWithURL(NSURL(string: imageName))
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildAllsubViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BTProductLikeListView {
    //MARK:- 设置所有子控件
    func buildAllsubViews() {
        //喜欢人数
        likeLabel = UILabel()
        likeLabel?.font = UIFont.systemFontOfSize(11)
        likeLabel?.textColor = UIColor.lightGrayColor()
        self.addSubview(likeLabel!)
        likeLabel?.snp_makeConstraints(closure: { (make) in
            make.leading.trailing.equalTo(self).offset(10)
            make.top.equalTo(5)
            make.height.equalTo(20)
        })
        
        //求出最大可显示头像数量
        maxNum = NSInteger(BTscreenW - 2 * margin - arrowW) / NSInteger(iconWH + margin)
        //搞一个容器存放出现的头像
        var lastView = UIImageView()
        var leftMargin: CGFloat = 10
        for _ in 0..<maxNum {
            let imageView = UIImageView()
            imageView.layer.cornerRadius = iconWH * 0.5
            imageView.layer.masksToBounds = true
            self.addSubview(imageView)
            imageViewArray.append(imageView)
            
            imageView.snp_makeConstraints(closure: { (make) in
                make.leading.equalTo(leftMargin)
                make.top.equalTo((self.likeLabel?.snp_bottom)!).offset(10)
                make.size.equalTo(iconWH)
            })
            leftMargin += (10 + iconWH)
            
            lastView = imageView
        }
        //箭头
        let arrowBtn = UIButton(type: .Custom)
        arrowBtn.setBackgroundImage(UIImage(named: "arrow_message_7x13_"), forState: .Normal)
        self.addSubview(arrowBtn)
        arrowBtn.snp_makeConstraints { (make) in
            make.trailing.equalTo(self).offset(-10)
            make.centerY.equalTo(lastView)
            make.size.equalTo(CGSize(width: 7, height: 13))
        }
        
        //上下边距
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0).CGColor
    }
}
