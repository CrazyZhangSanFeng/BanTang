//
//  BTSearchListCell.swift
//  BanTang
//
//  Created by 张灿 on 16/6/20.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit
import SDWebImage

class BTSearchListCell: UICollectionViewCell {
    
    /** 图片 */
    @IBOutlet weak var iconView: UIImageView!
    
    /** 标题 */
    @IBOutlet weak var nameLabel: UILabel!
    
    /** 英文标题 */
    @IBOutlet weak var en_nameLabel: UILabel!
    
    //模型
    var listModel: BTSearchListModel? {
        didSet {
            guard let listModel = listModel else {
                return
            }
            
            iconView.sd_setImageWithURL(NSURL(string: listModel.icon))
            
            nameLabel.text = listModel.name
            
            en_nameLabel.text = listModel.en_name
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
