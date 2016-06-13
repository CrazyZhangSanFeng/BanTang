//
//  BTProductBottomBar.swift
//  BanTang
//
//  Created by 张灿 on 16/6/11.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit
import SnapKit

class BTProductBottomBar: UIView {
    //模型
    var productDetailModel: ProductDetail? {
        didSet {
            guard let productDetailModel = productDetailModel else {
                return
            }
            commentBtn?.setTitle(productDetailModel.comments, forState: .Normal)
            likeBtn?.setTitle(productDetailModel.likes, forState: .Normal)
            
        }
    }
    
    //评论按钮
    var commentBtn: UIButton?
    
    //喜欢按钮
    var likeBtn: UIButton?
    
    //购买按钮
    var buyBtn: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildAllsubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}

extension BTProductBottomBar {
    func buildAllsubViews() {
        //评论按钮
        commentBtn = UIButton(type: .Custom)
        commentBtn?.setImage(UIImage(named: "product_not_commenticon_18x18_"), forState: .Normal)
        commentBtn?.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        commentBtn?.titleLabel?.font = UIFont.systemFontOfSize(16)
        commentBtn?.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        self.addSubview(commentBtn!)
        
        //喜欢按钮
        likeBtn = UIButton(type: .Custom)
        likeBtn?.setImage(UIImage(named: "btn_product_like_19x17_"), forState: .Normal)
        likeBtn?.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        likeBtn?.titleLabel?.font = UIFont.systemFontOfSize(16)
        likeBtn?.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        self.addSubview(likeBtn!)
        
        //购买按钮
        buyBtn = UIButton(type: .Custom)
        buyBtn?.setImage(UIImage(named: "btn_topic_buy_new_20x17_"), forState: .Normal)
        buyBtn?.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        buyBtn?.titleLabel?.font = UIFont.systemFontOfSize(16)
        buyBtn?.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        buyBtn?.setTitle("购买", forState: .Normal)
        self.addSubview(buyBtn!)
        
        let btnW: CGFloat = BTscreenW / 3
        
        commentBtn?.snp_makeConstraints(closure: { (make) in
            make.size.equalTo(CGSize(width: btnW, height: 50))
            make.leading.equalTo(self)
            make.centerY.equalTo(self)
        })
        
        likeBtn?.snp_makeConstraints(closure: { (make) in
            make.size.equalTo(CGSize(width: btnW, height: 50))
            make.leading.equalTo((commentBtn?.snp_trailing)!)
            make.centerY.equalTo(self)
        })
        
        buyBtn?.snp_makeConstraints(closure: { (make) in
            make.size.equalTo(CGSize(width: btnW, height: 50))
            make.leading.equalTo((likeBtn?.snp_trailing)!)
            make.centerY.equalTo(self)
        })
    }
}
