//
//  BTPopupView.swift
//  BanTang
//
//  Created by 张灿 on 16/6/17.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit

protocol BTPopupViewDelegate: class {
    func topClick()
    func bottomClick()
}

class BTPopupView: UIImageView {
    
    //代理
    weak var delegate: BTPopupViewDelegate?
    
    var topBtn: UIButton?
    var bottomBtn: UIButton?
    
    var popupV: BTPopupView?

    func popupView() -> BTPopupView {
        popupV = BTPopupView()
        popupV!.backgroundColor = UIColor.whiteColor()
        popupV!.userInteractionEnabled = true
        
        //按钮
        topBtn = UIButton(type: .Custom)
        bottomBtn = UIButton(type: .Custom)
        
        //按钮文字
        topBtn!.setTitle("我的关注", forState: .Normal)
        bottomBtn!.setTitle("种草小分队", forState: .Normal)
        
        //按钮文字颜色
        topBtn!.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        bottomBtn!.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        
        //按钮字体大小
        topBtn!.titleLabel?.font = UIFont.systemFontOfSize(14)
        bottomBtn!.titleLabel?.font = UIFont.systemFontOfSize(14)
        
        //按钮图片
        topBtn!.setImage(UIImage(named: "pop_cell_arrow_6x10_"), forState: .Normal)
        bottomBtn!.setImage(UIImage(named: "pop_cell_arrow_6x10_"), forState: .Normal)
        
        //按钮文字内边距
        topBtn!.titleEdgeInsets = UIEdgeInsets(top: 0, left: -25, bottom: 0, right: 25)
        bottomBtn!.titleEdgeInsets = UIEdgeInsets(top: 0, left: -19, bottom: 0, right: 19)
        
        //图片内边距调整
        topBtn!.imageEdgeInsets = UIEdgeInsets(top: 0, left: 75, bottom: 0, right: -75)
        bottomBtn!.imageEdgeInsets = UIEdgeInsets(top: 0, left: 81, bottom: 0, right: -81)
        
        //按钮点击
        topBtn!.addTarget(self, action: #selector(topBtnClick), forControlEvents: .TouchUpInside)
        bottomBtn!.addTarget(self, action: #selector(bottomBtnClick), forControlEvents: .TouchUpInside)
        
        //按钮位置
        topBtn!.frame = CGRect(x: 0, y: 0, width: 110, height: 40)
        bottomBtn!.frame = CGRect(x: 0, y: 40, width: 110, height: 40)
        
        popupV!.addSubview(topBtn!)
        popupV!.addSubview(bottomBtn!)
        
        popupV!.frame = CGRect(x: 20, y: 84, width: 110, height: 80)
        UIApplication.sharedApplication().keyWindow?.addSubview(popupV!)
        
        return popupV!
    }
    
    
    func topBtnClick() {
        
        //调用代理方法
        guard let delegate = delegate else {
            return
        }
        delegate.topClick()
    }
    
    func bottomBtnClick() {
        
        //调用代理方法
        guard let delegate = delegate else {
            return
        }
        delegate.bottomClick()
    }

}
