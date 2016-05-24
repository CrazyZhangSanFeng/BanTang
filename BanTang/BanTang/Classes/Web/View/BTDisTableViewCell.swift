//
//  BTDisTableViewCell.swift
//  BanTang
//
//  Created by 张灿 on 16/5/24.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit

class BTDisTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var nickname: UILabel!
    
    @IBOutlet weak var avatar: UIImageView!

    @IBOutlet weak var order_time_str: UILabel!
    
    @IBOutlet weak var views: UIButton!
    
    @IBOutlet weak var comments: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
