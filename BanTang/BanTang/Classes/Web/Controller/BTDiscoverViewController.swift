//
//  BTDiscoverViewController.swift
//  BanTang
//
//  Created by 张灿 on 16/5/23.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit

class BTDiscoverViewController: UITableViewController {
    //下划线属性
    let underLine = UIView()
    //懒加载左侧按钮
    lazy var leftButton: UIButton = {
        
        var leftButton = UIButton(type: .Custom)
        leftButton.setTitle("清单", forState: .Normal)
        leftButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        leftButton.setTitleColor(UIColor.redColor(), forState: .Selected)
        leftButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        leftButton.frame = CGRectMake(5, 0, 57.5, 44)
        leftButton.selected = true
        leftButton.addTarget(self, action: #selector(BTDiscoverViewController.clickLeft), forControlEvents: .TouchUpInside)
        
        return leftButton
    }()
    
    //懒加载右侧按钮
    lazy var rightButton: UIButton = {
        
        var rightButton = UIButton(type: .Custom)
        rightButton.setTitle("单品", forState: .Normal)
        rightButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        rightButton.setTitleColor(UIColor.redColor(), forState: .Selected)
        rightButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        rightButton.frame = CGRectMake(67.5, 0, 57.5, 44)
        rightButton.addTarget(self, action: #selector(BTDiscoverViewController.clickRight), forControlEvents: .TouchUpInside)
        
        return rightButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //添加左侧关注按钮
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "discovey_pop_btn_20x20_"), highlightImage: UIImage(named: "discovey_pop_press_btn_20x20_"), target: self, action: #selector(BTDiscoverViewController.attentation))
        
        //添加右侧创建按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "discover_write_article_icon_18x20_"), highlightImage: UIImage(named: "discover_write_article_highlisht_icon_19x20_"), target: self, action: #selector(BTDiscoverViewController.creatText))
        
        //添加导航栏中间的按钮
        setupTitleView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}

//MARK:- 导航栏左右两侧的点击
extension BTDiscoverViewController {
    //MARK:- 关注点击
    func attentation() {
        print("关注")
    }
    //MARK:- 创建文章点击
    func creatText() {
        print("创建文章")
    }
}

//MARK:- 设置导航栏中间的view
extension BTDiscoverViewController {
    

    
    func setupTitleView() {
        //创建容器
        let contentView = UIView(frame: CGRectMake(0, 0, 130, 44))
        
        //创建红色下划线
        underLine.backgroundColor = UIColor.redColor()
        underLine.frame.size.width = leftButton.frame.size.width - 20
        underLine.frame.size.height = 2
        underLine.center.x = leftButton.center.x
        underLine.frame.origin.y = contentView.frame.size.height - underLine.frame.size.height
        

        //添加按钮
        contentView.addSubview(leftButton)
        contentView.addSubview(rightButton)
        
        //添加下划线
        contentView.addSubview(underLine)
        
        
        self.navigationItem.titleView = contentView
        
    }
    
    //MARK:- 清单点击
    func clickLeft() {
        print("点击清单")
        rightButton.selected = false
        leftButton.selected = true
        
        //下划线动画
        UIView.animateWithDuration(0.25) { 
            self.underLine.center.x = self.leftButton.center.x
        }
        
        //添加右侧创建按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "discover_write_article_icon_18x20_"), highlightImage: UIImage(named: "discover_write_article_highlisht_icon_19x20_"), target: self, action: #selector(BTDiscoverViewController.creatText))
    }
    
    //MARK:- 单品点击
    func clickRight() {
        print("点击单品")
        leftButton.selected = false
        rightButton.selected = true
        
        //下划线动画
        UIView.animateWithDuration(0.25) {
            self.underLine.center.x = self.rightButton.center.x
        }
        
        //加载照相按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "discovey_camera_btn_24x19_"), highlightImage: UIImage(named: ""), target: self, action: #selector(BTDiscoverViewController.photoClick))
    }
    
    //MARK:- photo点击
    func photoClick() {
        print("点击照片")
    }
    
}
