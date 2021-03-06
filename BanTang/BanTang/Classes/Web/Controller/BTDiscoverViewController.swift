//
//  BTDiscoverViewController.swift
//  BanTang
//
//  Created by 张灿 on 16/5/23.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit

class BTDiscoverViewController: UIViewController {
    
    //用来记录关注按钮的选中状态,方便跳转的时候修改状态
    var attentationBtn: UIButton?
    
    //下划线属性
    let underLine = UIView()
    //懒加载左侧清单按钮
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
    
    //懒加载右侧单品按钮
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
        
        edgesForExtendedLayout = .None
        //添加左侧关注按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "discovey_pop_btn_20x20_"), highlightImage: UIImage(named: "discovey_pop_press_btn_20x20_"), target: self, action: #selector(BTDiscoverViewController.attentation(_:)))
        
        
        
        
        //添加右侧创建按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "discover_write_article_icon_18x20_"), highlightImage: UIImage(named: "discover_write_article_highlisht_icon_19x20_"), target: self, action: #selector(BTDiscoverViewController.creatText))
        
        //添加导航栏中间的按钮
        setupTitleView()
        
        //添加所有子控制器
        setupAllChildVC()
        
        //默认加载清单
        loadChildVC(0)

    }
    
}
//MARK:- 导航栏左右两侧的点击
extension BTDiscoverViewController: BTPopupViewDelegate {
    //MARK:- 关注点击
    func attentation(sender: UIButton) {
        
        attentationBtn = sender
        
        if attentationBtn!.selected == false {
          
            let cover = BTCoverView.popShow()
            
            let popupView = BTPopupView().popupView()
            popupView.delegate = self
            
            weak var weakself: BTCoverView? = cover
            
            //点击屏幕,做动画并且移除遮盖
            cover.click = {
                
                UIView.animateWithDuration(0.25, animations: {
                    
                    }, completion: { (_) in
                        popupView.removeFromSuperview()
                        weakself!.removeFromSuperview()
                        self.attentationBtn!.selected = !self.attentationBtn!.selected

                })
                
            }
            sender.selected = !sender.selected
        } else {
            
            UIApplication.sharedApplication().keyWindow?.subviews.last?.removeFromSuperview()
            UIApplication.sharedApplication().keyWindow?.subviews.last?.removeFromSuperview()
            self.attentationBtn!.selected = !self.attentationBtn!.selected

        }
        
        
        
    }
    //MARK:- 创建文章点击
    func creatText() {
        
        let creatTextVC = BTCreatTextVC()

        self.presentViewController(creatTextVC, animated: true, completion: nil)
    }
    
    //MARK:- 左侧pop按钮点击代理实现
    func topClick() {
            //移除弹出的遮盖还有popupView
            UIApplication.sharedApplication().keyWindow?.subviews.last?.removeFromSuperview()
        UIApplication.sharedApplication().keyWindow?.subviews.last?.removeFromSuperview()
            attentationBtn?.selected = !(attentationBtn?.selected)!
        
        let attationVC = UITableViewController()
        attationVC.title = "关注"
        navigationController?.pushViewController(attationVC, animated: true)
        
    }
    
    func bottomClick() {
            //移除弹出的遮盖还有popupView
            UIApplication.sharedApplication().keyWindow?.subviews.last?.removeFromSuperview()
        UIApplication.sharedApplication().keyWindow?.subviews.last?.removeFromSuperview()
        attentationBtn?.selected = !(attentationBtn?.selected)!
        
        let zhongcaoVC = BTZhongcaoQueueTVC(style: .Grouped)
        zhongcaoVC.title = "种草小分队"
        navigationController?.pushViewController(zhongcaoVC, animated: true)
        
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
        
        //创建中间分割线
        let middleLine = UIView()
        middleLine.backgroundColor = UIColor.lightGrayColor()
        middleLine.frame.size.width = 1
        middleLine.frame.size.height = 15
        middleLine.frame.origin.x = contentView.frame.size.width * 0.5
        middleLine.frame.origin.y = 15
        middleLine.alpha = 0.7
        

        //添加按钮
        contentView.addSubview(leftButton)
        contentView.addSubview(rightButton)
        
        //添加下划线
        contentView.addSubview(underLine)
        
        //添加分割线
        contentView.addSubview(middleLine)
        
        
        self.navigationItem.titleView = contentView
        
    }
    
    //MARK:- 清单点击
    func clickLeft() {
        
        rightButton.selected = false
        leftButton.selected = true
        
        //下划线动画
        UIView.animateWithDuration(0.25) { 
            self.underLine.center.x = self.leftButton.center.x
        }
        
        //添加右侧创建按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "discover_write_article_icon_18x20_"), highlightImage: UIImage(named: "discover_write_article_highlisht_icon_19x20_"), target: self, action: #selector(BTDiscoverViewController.creatText))
        
            loadChildVC(0)
        
    }
    
    //MARK:- 单品点击
    func clickRight() {
        
        leftButton.selected = false
        rightButton.selected = true
        
        //下划线动画
        UIView.animateWithDuration(0.25) {
            self.underLine.center.x = self.rightButton.center.x
        }
        
        //加载照相按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "discovey_camera_btn_24x19_"), highlightImage: UIImage(named: ""), target: self, action: #selector(BTDiscoverViewController.photoClick))
        
            loadChildVC(1)
        
    }
    
    //MARK:- photo点击
    func photoClick() {
        print("点击照片")
        let photoVC = UIImagePickerController()
        photoVC.sourceType = .PhotoLibrary
        
        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(photoVC, animated: true, completion: nil)
    }
    
}

//MARK:- 添加所有子控制器
extension BTDiscoverViewController {
    func setupAllChildVC() {
        //清单
        let listVC = BTListViewController()
        self.addChildViewController(listVC)
        
        //单品
        let danpinVC = BTDanpinViewController()
        
        self.addChildViewController(danpinVC)
    }
}


//MARK:- 点击按钮切换控制器
extension BTDiscoverViewController {
    func loadChildVC(tag : NSInteger) {
        view.subviews.last?.removeFromSuperview()
        
        let vc = self.childViewControllers[tag]
        
        if (vc.view.superview != nil) {return}
        
        vc.view.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        
        view.addSubview(vc.view)
       
    }
}
