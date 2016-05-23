//
//  UIBarButtonItem+Item.m
//  BaiSi
//
//  Created by 张灿 on 16/4/25.
//  Copyright © 2016年 张灿. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)
+ (instancetype)itemWithImage:(UIImage *)image highlightImage:(UIImage *)highImage Target:(nullable id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    UIView *contentV = [[UIView alloc] initWithFrame:btn.bounds];
    [contentV addSubview:btn];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:contentV];
}

+ (instancetype)itemWithImage:(UIImage *)image selImage:(UIImage *)selImage Target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn sizeToFit];
    UIView *contentV = [[UIView alloc] initWithFrame:btn.bounds];
    [contentV addSubview:btn];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:contentV];
}

@end
