//
//  BTSingNumberCell.swift
//  BanTang
//
//  Created by 张灿 on 16/6/26.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit

class BTSingNumberCell: UITableViewCell {

    @IBOutlet weak var numLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //去兑换
    @IBAction func duihuanBtn(sender: AnyObject) {
    }
}
