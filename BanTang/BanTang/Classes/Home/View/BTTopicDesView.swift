//
//  BTTopicDesView.swift
//  BanTang
//
//  Created by 张灿 on 16/6/9.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit
import SnapKit

class BTTopicDesView: UIView {
    //模型
    var productModel: BTProductModel?
    
    //边距
    var margin: CGFloat = 10
    
    //顶部图片的高度
    let topImageH: CGFloat = 0.55 * BTscreenW
    
    //标题
    var titleLabel: UILabel?
    
    //内容
    var desLabel: UILabel?
    
    //根据传入的模型获得高度
    func viewHeight(productModel: BTProductModel) -> CGFloat {
        
        titleLabel?.text = productModel.title
        desLabel?.text = productModel.desc
        self.layoutIfNeeded()
        return CGRectGetMaxY(desLabel!.frame)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel = UILabel()
        titleLabel?.font = UIFont.systemFontOfSize(18)
        titleLabel?.textColor = UIColor.darkGrayColor()
        desLabel = UILabel()
        desLabel?.font = UIFont.systemFontOfSize(15)
        desLabel?.preferredMaxLayoutWidth = BTscreenW - 2 * margin
        desLabel?.numberOfLines = 0
        self.addSubview(titleLabel!)
        self.addSubview(desLabel!)
        
        titleLabel?.snp_makeConstraints(closure: { (make) in
            make.leading.equalTo(10)
            make.top.equalTo(10)
            make.trailing.equalTo(-10)
            make.height.equalTo(30)
        })
        
        desLabel?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo((titleLabel?.snp_bottom)!).offset(10)
            make.leading.equalTo(10)
            make.trailing.equalTo(-10)
            
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
