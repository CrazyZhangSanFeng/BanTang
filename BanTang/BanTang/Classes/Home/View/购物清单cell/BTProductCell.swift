//
//  BTProductCell.swift
//  BanTang
//
//  Created by 张灿 on 16/6/10.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit
import SnapKit

/** 边距 */
private let margin: CGFloat = 10

class BTProductCell: UITableViewCell {

    /** 头像地址域名 */
    var userAvatrHost: String?
    
    /** 产品图片地址域名 */
    var productPicHost: String?
    
    //标号
    var rankImageView: UIImageView?
    //标题
    var titleLabel: UILabel?
    //内容
    var desLabel: UILabel?
    //图片view
    var picView: BTProductPicView?
    //价格
    var priceLabel: UILabel?
    //喜欢列表view
    var likeListView: BTProductLikeListView?
    //底部按钮view
    var bottomBar: BTProductBottomBar?
    //底部分割线
    var separatorView: UIView?

    
    //模型
    var detailModel: ProductDetail? {
        didSet {
            guard let detailModel = detailModel else {
                return
            }
            rankImageView?.image = UIImage(named: "good\(self.tag + 1)_15x23_")
            titleLabel?.text = detailModel.title
            desLabel?.text = detailModel.desc
            picView?.picUrlHost = productPicHost
            picView?.images = detailModel.pic
            priceLabel?.text = "参考价: ¥\(detailModel.price)"
            likeListView?.userAvatrHost = userAvatrHost
            likeListView?.productDetailModel = detailModel
            bottomBar?.productDetailModel = detailModel
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //加载所有子控件
        buildAllSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func cellWithTableView(tableView: UITableView) -> BTProductCell {
        let cellID = "productDetailCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? BTProductCell
        if cell == nil {
            cell = BTProductCell(style: .Default, reuseIdentifier: cellID)
        }
        cell!.selectionStyle = .None
        return cell!
    }

}



//MARK:- 设置所有子控件
extension BTProductCell {
    
    func buildAllSubViews() {
        //标号
        rankImageView = UIImageView()
        self.contentView.addSubview(rankImageView!)
        
        //标题
        titleLabel = UILabel()
        titleLabel?.font = UIFont.systemFontOfSize(18)
        titleLabel?.textColor = UIColor.darkGrayColor()
        titleLabel?.numberOfLines = 1
        self.contentView.addSubview(titleLabel!)
        
        //内容
        desLabel = UILabel()
        desLabel?.font = UIFont.systemFontOfSize(15)
        desLabel?.textColor = UIColor.lightGrayColor()
        desLabel?.numberOfLines = 0
        desLabel?.preferredMaxLayoutWidth = BTscreenW - 2 * margin
        desLabel?.sizeToFit()
        self.contentView.addSubview(desLabel!)
        
        //图片view
        picView = BTProductPicView()
        self.contentView.addSubview(picView!)
        
        //价格标签
        priceLabel = UILabel()
        priceLabel?.font = UIFont.systemFontOfSize(15)
        priceLabel?.textAlignment = .Right
        priceLabel?.textColor = UIColor.redColor()
        self.contentView.addSubview(priceLabel!)
        
        //喜欢列表view
        likeListView = BTProductLikeListView()
        self.contentView.addSubview(likeListView!)
        
        //底部按钮
        bottomBar = BTProductBottomBar()
        self.contentView.addSubview(bottomBar!)
        
        //分割线
        separatorView = UIView()
        separatorView?.backgroundColor = UIColor(red: 239/255.0, green: 239/255.0, blue: 239/255.0, alpha: 1.0)
        self.contentView.addSubview(separatorView!)
        
        //约束
        rankImageView?.snp_makeConstraints(closure: { (make) in
            make.size.equalTo(CGSize(width: 15, height: 23))
            make.leading.top.equalTo(self.contentView).offset(margin)
        })
        
        titleLabel?.snp_makeConstraints(closure: { (make) in
            make.centerY.equalTo(rankImageView!)
            make.leading.equalTo((rankImageView?.snp_trailing)!).offset(margin)
            make.trailing.equalTo(self.contentView).offset(-margin)
            make.height.equalTo(30)
        })
        
        desLabel?.snp_makeConstraints(closure: { (make) in
            make.leading.equalTo(self.contentView).offset(margin)
            make.trailing.equalTo(self.contentView).offset(-margin)
            make.top.equalTo((rankImageView?.snp_bottom)!).offset(margin)
        })
        
        picView?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo((desLabel?.snp_bottom)!).offset(margin)
            make.leading.equalTo(desLabel!)
            make.trailing.equalTo(desLabel!)
        })
        
        priceLabel?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo((picView?.snp_bottom)!).offset(margin)
            make.trailing.equalTo(desLabel!)
            make.leading.equalTo(desLabel!)
            make.height.equalTo(30)
        })
        
        likeListView?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo((priceLabel?.snp_bottom)!).offset(margin)
            make.leading.equalTo(self.contentView)
            make.trailing.equalTo(self.contentView)
            make.height.equalTo(70)
        })
        
        bottomBar?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo((likeListView?.snp_bottom)!)
            make.leading.trailing.equalTo(self.contentView)
            make.height.equalTo(50)
        })
        
        separatorView?.snp_makeConstraints(closure: { (make) in
            make.leading.trailing.equalTo(self.contentView)
            make.top.equalTo((bottomBar?.snp_bottom)!)
            make.height.equalTo(10)
            make.bottom.equalTo(self.contentView.snp_bottom)
        })
        
        
    }
    

    
}
