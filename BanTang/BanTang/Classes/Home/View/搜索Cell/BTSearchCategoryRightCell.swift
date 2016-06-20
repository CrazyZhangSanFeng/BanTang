//
//  BTSearchCategoryRightCell.swift
//  BanTang
//
//  Created by 张灿 on 16/6/20.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit
import SDWebImage

class BTSearchCategoryRightCell: UICollectionViewCell {
    /** 图片 */
    @IBOutlet weak var iconView: UIImageView!
    
    /** 标题 */
    @IBOutlet weak var nameLabel: UILabel!
    
    var subclass: subclassModel? {
        didSet {
            guard let subclass = subclass else {
                return
            }
            iconView.sd_setImageWithURL(NSURL(string: subclass.icon))
            nameLabel.text = subclass.name
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
