//
//  BTDisTableViewCell.swift
//  BanTang
//
//  Created by 张灿 on 16/5/24.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit
import SDWebImage

class BTDisTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var nickname: UILabel!
    
    @IBOutlet weak var avatar: UIImageView!

    @IBOutlet weak var order_time_str: UILabel!
    
    @IBOutlet weak var views: UILabel!
    
    @IBOutlet weak var comments: UILabel!
    
    //设置cell的显示内容
    var topicItem : BTTopicItem? {
        didSet {
            //先校验是否有值
            guard let topicItem = topicItem else {
                return
            }
            
            title.text = topicItem.title
            order_time_str.text = topicItem.order_time_str
            views.text = topicItem.views
            comments.text = topicItem.comments
            
            nickname.text = topicItem.user?.nickname
            
            let url = NSURL(string: (topicItem.user?.avatar)!)
            
            avatar.sd_setImageWithURL(url, placeholderImage: UIImage(named: "default_user_loading_icon_100x100_"))
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置头像圆角
        
        avatar.layer.cornerRadius = self.avatar.frame.size.width * 0.5;
        avatar.layer.masksToBounds = true;
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
