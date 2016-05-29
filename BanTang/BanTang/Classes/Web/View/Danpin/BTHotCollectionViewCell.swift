//
//  BTHotCollectionViewCell.swift
//  BanTang
//
//  Created by 张灿 on 16/5/29.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit
import SDWebImage

class BTHotCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageV: UIImageView!
    
    var hotItem: BTHotItem? {
        didSet {
            guard let hotItem = hotItem else {
                return
            }
            
            //******设置图片*****
            let urlStr = hotItem.mini_pic_url   
            let urlStr0 = (urlStr as NSString).stringByReplacingOccurrencesOfString("!w200", withString: "")
                
            let url = NSURL(string: urlStr0)
            
            imageV.sd_setImageWithURL(url, placeholderImage: UIImage(named: "default_user_icon_75x75_"))
            //******设置图片*****
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
