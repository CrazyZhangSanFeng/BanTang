//
//  BTHomeTopicCell.swift
//  BanTang
//
//  Created by 张灿 on 16/6/6.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit
import SDWebImage

class BTHomeTopicCell: UITableViewCell {
    //图片
    @IBOutlet weak var pic: UIImageView!
    //标题
    @IBOutlet weak var title: UILabel!
    //爱心
    @IBOutlet weak var likeImageView: UIImageView!
    //喜欢数
    @IBOutlet weak var likes: UILabel!
    //用户头像
    @IBOutlet weak var avatar: UIButton!
    //用户名
    @IBOutlet weak var nickname: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //用户头像圆角处理
        avatar.layer.cornerRadius = avatar.bounds.size.width * 0.5
        avatar.layer.masksToBounds = true
    }
    
    //模型属性
    var homeTopicItem: BTHomeTopic? {
        didSet {
            guard let homeTopicItem = homeTopicItem else{
                return
            }
            //图片
            let urlStr = homeTopicItem.pic
            let url = NSURL(string: urlStr)
            pic.sd_setImageWithURL(url, placeholderImage: UIImage(named: "default_user_icon_75x75_"))
            //标题
            title.text = homeTopicItem.title
            //判断是否显示用户信息(头像,用户名,星星还是爱心)
            if homeTopicItem.type == "2" {
                likeImageView.image = UIImage(named: "article_star_icon_13x11_")
                avatar.hidden = false
                let url = NSURL(string: (homeTopicItem.user?.avatar)!)
                avatar.sd_setImageWithURL(url, forState: .Normal, placeholderImage: UIImage(named: "center_nar_icon_21x22_"))
                nickname.hidden = false
                nickname.text = homeTopicItem.user?.nickname
            } else if homeTopicItem.type == "" {
                
                //变爱心
                likeImageView.image = UIImage(named: "home_likes_icon_13x11_")
                avatar.hidden = true
                nickname.hidden = true
            }
            //喜欢数
            likes.text = homeTopicItem.likes
            
        }
    }
    
    class func cellWithTableView(tableView: UITableView) -> BTHomeTopicCell {
        let cellID = "BTHomeTopicCell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? BTHomeTopicCell
        
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("BTHomeTopicCell", owner: nil, options: nil).first as? BTHomeTopicCell
        }
        
        return cell!
    }
    
}
