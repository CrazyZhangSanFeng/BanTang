//
//  UIBarButtonItem+Item.h
//  BaiSi
//
//  Created by 张灿 on 16/4/25.
//  Copyright © 2016年 张灿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)

+ (instancetype)itemWithImage:(UIImage *)image highlightImage:(UIImage *)highImage Target:(id)target action:(SEL)action;

+ (instancetype)itemWithImage:(UIImage *)image selImage:(UIImage *)selImage Target:(id)target action:(SEL)action;

@end
