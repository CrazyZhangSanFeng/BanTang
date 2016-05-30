//
//  BTUserHeadView.swift
//  BanTang
//
//  Created by 张灿 on 16/5/30.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit

class BTUserHeadView: UIView {

    @IBOutlet weak var userIcon: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //用户头像圆角处理
        userIcon.layer.cornerRadius = userIcon.frame.size.width * 0.5
        userIcon.layer.masksToBounds = true
    }

}
