//
//  BTProductPicView.swift
//  BanTang
//
//  Created by 张灿 on 16/6/11.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class BTProductPicView: UIView {

    //图片数组
    var images: [PicModel]? {
        //设置图片
        didSet {
            guard let images = images else {
                return
            }
            if images.count == 2 {
                let imageName1: String = picUrlHost! + images[0].p
                let imageName2: String = picUrlHost! + images[1].p
                oneImageView?.sd_setImageWithURL(NSURL(string: imageName1))
                twoImageView?.sd_setImageWithURL(NSURL(string: imageName2))
                twoImageView?.snp_remakeConstraints(closure: { (make) in
                    make.leading.trailing.equalTo(self)
                    make.top.equalTo((oneImageView?.snp_bottom)!).offset(5)
                    make.height.equalTo(self.snp_width)
                    make.bottom.equalTo(self)
                })
            }else if images.count == 1  {
                let imageName: String = picUrlHost! + images[0].p
                oneImageView?.sd_setImageWithURL(NSURL(string: imageName))
                twoImageView?.snp_remakeConstraints(closure: { (make) in
                    make.leading.trailing.equalTo(self)
                    make.top.equalTo((oneImageView?.snp_bottom)!).offset(5)
                    make.height.equalTo(0)
                    make.bottom.equalTo(self.snp_bottom)
                })
            }
        }
    }
    
    var picUrlHost: String?
    
    var oneImageView: UIImageView?
    var twoImageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //加载两张图片(可能是一张,但是不管,先都加上,然后再另外判断)
        oneImageView = UIImageView()
        self.addSubview(oneImageView!)
        twoImageView = UIImageView()
        self.addSubview(twoImageView!)
        //约束
        oneImageView?.snp_makeConstraints(closure: { (make) in
            make.top.leading.trailing.equalTo(self)
            make.height.equalTo(self.snp_width)
        })
        twoImageView?.snp_makeConstraints(closure: { (make) in
            make.leading.trailing.equalTo(self)
            make.top.equalTo((oneImageView?.snp_bottom)!).offset(5)
            make.height.equalTo(self.snp_width)
            make.bottom.equalTo(self)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
