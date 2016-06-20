//
//  BTSearchCategoryTableViewCell.swift
//  BanTang
//
//  Created by 张灿 on 16/6/20.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit

class BTSearchCategoryTableViewCell: UITableViewCell {
    /** 标题 */
    @IBOutlet weak var nameLabel: UILabel!
    
    /** 红色线 */
    @IBOutlet weak var redLineView: UIView!
    
    /** cell模型 */
    var categoryModel: BTSearchDanpinModel? {
        didSet {
            guard let categoryModel = categoryModel else {
                return
            }
            nameLabel.text = categoryModel.name
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //取消cell的选中样式
        self.selectionStyle = .None
    }

    //cell 选中与不选中都会点用这个方法
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        redLineView.hidden = !selected
        if selected == true {
            nameLabel.textColor = UIColor.redColor()
            self.backgroundColor = UIColor.whiteColor()
        } else {
            self.backgroundColor = UIColor(red: 240 / 255.0, green: 240 / 255.0, blue: 240 / 255.0, alpha: 1.0)
            nameLabel.textColor = UIColor.blackColor()
        }
    }
    
}
