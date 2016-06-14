//
//  BTPushTransitionAnimator.swift
//  BanTang
//
//  Created by 张灿 on 16/6/14.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit


class BTPushTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var transitionContext: UIViewControllerContextTransitioning?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        let containerView = transitionContext.containerView()
        let homeViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! BTHomeViewController
        homeViewController.tabBarController?.tabBar.hidden = true
        let productController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! BTProductDetailVC
        containerView?.addSubview((productController.view)!)
        let topViewFrame: CGRect = (productController.topImageView?.frame)!
        
        let tableView = BTHomeViewController().currentChildVc.tableView
        let homeCell = tableView.cellForRowAtIndexPath(tableView!.indexPathForSelectedRow!) as! BTHomeTopicCell
        let imageView = UIImageView(image: homeCell.pic.image)
        
        let frameInSuperView: CGRect = homeCell.pic.convertRect(homeCell.pic.frame, toView: homeViewController.view)
        productController.topImageViewFrameInHomeView = frameInSuperView
        imageView.alpha = 0.0
        imageView.frame = frameInSuperView
        containerView?.addSubview(imageView)
        
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseOut, animations: { 
            imageView.frame = topViewFrame
            imageView.alpha = 1.0
            }) { (_) in
                transitionContext.completeTransition(!(transitionContext.transitionWasCancelled()))
                productController.topImageView?.image = imageView.image
                imageView.removeFromSuperview()
        }
        
        
    }

}
