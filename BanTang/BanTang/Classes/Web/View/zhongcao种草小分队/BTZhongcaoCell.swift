//
//  BTZhongcaoCell.swift
//  BanTang
//
//  Created by 张灿 on 16/6/19.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit
import SDWebImage



class BTZhongcaoCell: UITableViewCell {
    
    /** 图片 */
    @IBOutlet weak var bigImageView: UIImageView!
    
    /** 标题 */
    @IBOutlet weak var nameLabel: UILabel!
    
    /** 浏览 */
    @IBOutlet weak var viewsLabel: UILabel!
    
    /** 帖子 */
    @IBOutlet weak var postLabel: UILabel!
    
    //模型
    var zhongcaoItem: BTZhongcaoItem? {
        didSet {
            guard let zhongcaoItem = zhongcaoItem else {
                return
            }
            //图片
            bigImageView.sd_setImageWithURL(NSURL(string: zhongcaoItem.pic2))
            
            //标题
            nameLabel.text = zhongcaoItem.name
            
            //浏览量
            viewsLabel.text = (zhongcaoItem.dynamic?.views)! + "浏览"
            
            //帖子量
            postLabel.text = (zhongcaoItem.dynamic?.posts)! + "帖子"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        //设置标题的边框等属性
        nameLabel.layer.borderWidth = 1
        nameLabel.layer.cornerRadius = 3
        nameLabel.layer.borderColor = UIColor.whiteColor().CGColor
    }


    
}
