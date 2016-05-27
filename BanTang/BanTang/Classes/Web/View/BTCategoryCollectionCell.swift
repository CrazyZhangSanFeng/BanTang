//
//  BTCategoryCollectionCell.swift
//  BanTang
//
//  Created by 张灿 on 16/5/27.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit
import SDWebImage

class BTCategoryCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    //懒加载cell模型属性
    var categoryItem : BTCategoryItem? {
        didSet {
            guard let categoryItem = categoryItem else {
                return
            }
            
            let urlStr = categoryItem.pic
            let url = NSURL(string: urlStr)
            imageView.sd_setImageWithURL(url)
            
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 3
        self.layer.masksToBounds = true
    }

}
