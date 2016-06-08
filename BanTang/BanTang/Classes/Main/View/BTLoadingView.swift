//
//  BTLoadingView.swift
//  BanTang
//
//  Created by 张灿 on 16/6/8.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit

public let BTscreenW = UIScreen.mainScreen().bounds.size.width
public let BTscreenH = UIScreen.mainScreen().bounds.size.height

class BTLoadingView: UIView {

    static let shareInstance = BTLoadingView()
    
    lazy var imageView: UIImageView = {
       var imageView = UIImageView()
        return imageView
    }()
    
    lazy var imagesArray: [UIImage] = {
        var imagesArray = [UIImage]()
        for i in 1..<22 {
            let imageName: String = "loading\(i)_105x18_@1x"
            let image = UIImage(named: imageName)
            imagesArray.append(image!)
        }
        return imagesArray
    }()
    

    func loadingViewToView(toView: UIView) -> UIView{
        
        return BTLoadingView.init(frame: toView.frame)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let h: CGFloat = 9
        let w: CGFloat = 52.5
        let x: CGFloat = (frame.size.width - w) * 0.5
        let y: CGFloat = (frame.size.height - h) * 0.5
        self.frame = CGRect(x: x, y: y, width: w, height: h)
        imageView.frame = self.bounds
        self.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimation() {
        self.hidden = false
        if imageView.isAnimating() {
            return
        }
        imageView.animationImages = imagesArray
        imageView.animationDuration = 1
        imageView.animationRepeatCount = 100000000000000000
        imageView.startAnimating()
    }
    
    func hideAnimation() {
        if !imageView.isAnimating() {
            return
        }
        self.hidden = true
        imageView.stopAnimating()
        imagesArray.removeAll()
        
    }
    
    
}
