//
//  BTSingTopView.swift
//  BanTang
//
//  Created by 张灿 on 16/6/26.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit
import SnapKit

class BTSingTopView: UIView {

    let imageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //图片
        let imageView = UIImageView()
        let path = NSBundle.mainBundle().pathForResource("sign_background", ofType: "jpg")
        imageView.image = UIImage(contentsOfFile: path!)
        self.addSubview(imageView)
        
        //底部
        let bottomView = UIView()
        let topLabel = UILabel()
        topLabel.text = "连续签到0天"
        topLabel.textColor = UIColor.lightGrayColor()
        topLabel.font = UIFont.systemFontOfSize(13)
        bottomView.addSubview(topLabel)
        
        let bottomLabel = UILabel()
        bottomLabel.text = "连续签到明天可获得额外的10分奖励"
        bottomLabel.textColor = UIColor.lightGrayColor()
        bottomLabel.font = UIFont.systemFontOfSize(12)
        bottomView.addSubview(bottomLabel)
        
        let signBtn = UIButton(type: .Custom)
        signBtn.setImage(UIImage(named: "sign_calendar_icon_30x30_"), forState: .Normal)
        bottomView.addSubview(signBtn)
        
        self.addSubview(bottomView)
        
        //约束
        imageView.snp_makeConstraints { (make) in
            make.top.leading.equalTo(5)
            make.trailing.equalTo(-5)
            make.height.equalTo(450)
        }
        
        topLabel.snp_makeConstraints { (make) in
            make.top.equalTo(25)
            make.leading.equalTo(8)
        }
        
        bottomLabel.snp_makeConstraints { (make) in
            make.top.equalTo(topLabel.snp_bottom).offset(8)
            make.leading.equalTo(8)
        }
        
        signBtn.snp_makeConstraints { (make) in
            make.top.equalTo(25)
            make.trailing.equalTo(-20)
            make.width.height.equalTo(30)
        }
        
        bottomView.snp_makeConstraints { (make) in
            make.top.equalTo(imageView.snp_bottom)
            make.height.equalTo(80)
            make.leading.bottom.trailing.equalTo(self)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
