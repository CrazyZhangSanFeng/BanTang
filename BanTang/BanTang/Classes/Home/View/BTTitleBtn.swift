//
//  BTTitleBtn.swift
//  BanTang
//
//  Created by 张灿 on 16/6/9.
//  Copyright © 2016年 张灿. All rights reserved.
// 购物清单 悬停标题栏的 自定义按钮

import UIKit

class BTTitleBtn: UIButton {
    //中间线
    var middleV: UIView?
    //是否隐藏中间线
    var isHiddenMiddle: Bool? {
        didSet {
            guard let isHiddenMiddle = isHiddenMiddle else {
                return
            }
            if isHiddenMiddle {
                middleV?.hidden = true
            } else {
                middleV?.hidden = false
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        middleV = UIView()
        middleV?.backgroundColor = UIColor(red: 50/255.0, green: 50/255.0, blue: 50/255.0, alpha: 1.0)
        self.addSubview(middleV!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //布局子控件
    override func layoutSubviews() {
        super.layoutSubviews()
        let middleH: CGFloat = self.frame.size.height * 0.5
        let y: CGFloat = (self.frame.size.height - middleH) * 0.5
        middleV?.frame = CGRect(x: self.frame.size.width, y: y, width: 1, height: middleH)
    }
    
    
}
