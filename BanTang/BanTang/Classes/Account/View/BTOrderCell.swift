//
//  BTOrderCell.swift
//  BanTang
//
//  Created by 张灿 on 16/5/31.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit

class BTOrderCell: UITableViewCell {

    //重写订单界面cell的边距
    override var frame: CGRect {
        didSet {
            
            super.frame.size.height -= 1
            
        }
    }

}
