//
//  BTReSetCell.swift
//  BanTang
//
//  Created by 张灿 on 16/5/31.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit

class BTReSetCell: UITableViewCell {
    
    
    
    //重新设置界面cell的边距
    override var frame: CGRect {
        didSet {
            
            super.frame.origin.x += 10
            
            super.frame.size.width -= 20
        }
    }


}
