//
//  ZCFileManager.h
//  BaiSi
//
//  Created by 张灿 on 16/5/1.
//  Copyright © 2016年 张灿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCFileManager : NSObject

/**
 *  指定一个文件夹路径，就获取文件夹尺寸
 *
 *  @param directoryPath 文件夹全路径
 *
 *  @return 文件夹尺寸
 */
+ (NSInteger)getSizeOfDirectoryPath:(NSString *)directoryPath;

/**
 *  指定一个文件夹路径，删除
 *
 *  @param directoryPath 文件夹全路径
 */
+ (void)removeDirectoryPath:(NSString *)directoryPath;

@end
