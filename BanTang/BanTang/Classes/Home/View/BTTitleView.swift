//
//  BTTitleView.swift
//  BanTang
//
//  Created by 张灿 on 16/6/9.
//  Copyright © 2016年 张灿. All rights reserved.
// 购物清单的悬停标题栏

import UIKit

protocol BTTitleViewDelegate: NSObjectProtocol {
    
    func titleView(titleView: BTTitleView, didClickBtnIndex btnIndex: NSInteger) -> ()
}

class BTTitleView: UIView {
    //代理属性
    weak var delegate: BTTitleViewDelegate?
    
    //底层线
    var bottomLine: UIView?
    
    //中间线
    var middleV: UIView?
    
    //当前选中的按钮
    var selectBtn: UIButton?
    
    //按钮宽度
    var btnW: CGFloat?
    
    //传入的标题数组
    var titleArray: [String]? {
        didSet {
            guard let titleArray = titleArray else {
                return
            }
            
            for title in titleArray {
                let rightbtn = BTTitleBtn(type: .Custom)
                
                rightbtn.setTitle(title, forState: .Normal)
                //设置按钮选中时的状态
                rightbtn.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
                rightbtn.setTitleColor(UIColor.darkGrayColor(), forState: .Selected)
                self.addSubview(rightbtn)
                rightbtn.addTarget(self, action: #selector(BTTitleView.btnClick(_:)), forControlEvents: .TouchUpInside)
                if self.subviews.count == titleArray.count {
                   rightbtn.isHiddenMiddle = true
                }
            }
            setBottomLine()
        }
    }
    
}

extension BTTitleView {
    //设置下划线
    func setBottomLine() {
        bottomLine = UIView()
        bottomLine?.backgroundColor = UIColor.redColor()
        self.addSubview(bottomLine!)
    }
    
    //按钮点击
    func btnClick(btn: UIButton) {
        selectBtn?.selected = false
        btn.selected = true
        selectBtn = btn
        
        UIView.animateWithDuration(0.25) { 
            self.bottomLine?.center.x = btn.center.x
        }
        
        //调用代理
        delegate?.titleView(self, didClickBtnIndex: btn.tag)
    }
    
    //布局子控件
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let count = self.subviews.count - 1
        btnW = self.frame.size.width / CGFloat(count)
        let btnH: CGFloat = self.frame.size.height
        for i in 0..<count {
            let btn: BTTitleBtn = self.subviews[i] as! BTTitleBtn
            btn.frame = CGRect(x: CGFloat(i) * btnW!, y: 0, width: btnW!, height: btnH)
            btn.tag = i
            if i == 0 {
                btnClick(btn)
                bottomLine?.frame.size.width = btnW! * 0.4
                bottomLine?.center.x = btn.center.x
                bottomLine?.frame.origin.y = self.frame.size.height - 2
                bottomLine?.frame.size.height = 2
            }
        }
        
    }
    
    
}
