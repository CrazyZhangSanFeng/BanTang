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
    
    @IBOutlet weak var imageView0: UIImageView!
    
    @IBOutlet weak var imageView1: UIImageView!
    
    @IBOutlet weak var imageView2: UIImageView!
    
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
            
            setImageView(0, imageView: imageView0)
            
            setImageView(1, imageView: imageView1)
            
            setImageView(2, imageView: imageView2)
            
        }
        
    }
    
    //:MARK- 设置cell中间的图片
    func setImageView(count: NSInteger, imageView: UIImageView) {
        if let dict = topicItem!.pics![count] as? [String : String]{
            let urlStr = dict["url"]!
                
            let urlStr0 = (urlStr as NSString).stringByReplacingOccurrencesOfString("!300x300", withString: "")
                
            let url = NSURL(string: urlStr0)
            imageView.sd_setImageWithURL(url)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置头像圆角
        avatar.layer.cornerRadius = self.avatar.frame.size.width * 0.5;
        avatar.layer.masksToBounds = true;
    }
    
    //重写frame方法,扩大cell间距,造成分割线
    override var frame: CGRect{
        didSet{
            super.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: frame.size.height - 10)
        }
    }
 
}
