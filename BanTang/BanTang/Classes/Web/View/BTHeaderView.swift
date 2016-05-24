//
//  BTHeaderView.swift
//  BanTang
//
//  Created by 张灿 on 16/5/24.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit

class BTHeaderView: UIView {

    @IBOutlet weak var hotBtn: UIButton!

    @IBOutlet weak var newBtn: UIButton!
    
    //最热点击
    @IBAction func hotClick(sender: AnyObject) {
        hotBtn.selected = true
        newBtn.selected = false
    }
    
    //最新点击
    @IBAction func newClick(sender: AnyObject) {
        newBtn.selected = true
        hotBtn.selected = false
    }
    
    override func awakeFromNib() {
        hotBtn.selected = true
    }
    
}
