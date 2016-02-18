//
//  Utils.h
//  my-Project-Car
//
//  Created by ntms on 16/1/30.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject


/**
 *  传入时间格式的字符串返回几小时前 几小时后
 *
 *  @param aString 时间格式的字符串 ：2016-1-30 10:50:30
 *
 *  @return 几小时前，很久以前？
 */
+(NSString *)pastTimeDescWithString:(NSString *)aString;

/**
 *  开始小菊花旋转
 */
+(void)networkStartRefreshing;
/**
 *  停止小小菊花旋转
 */
+(void)networkStopRefreshing;
/**
 *  提示网络错误
 */
+(void)noticeNetworkError;
/**
 *  获取SDWebImage缓存图片大小
 *
 *  @return 缓存 MB
 */
+(CGFloat)getSDWebImageCacheSize;
/**
 *  清理SDWebImage缓存
 */
+(void)clearSDWebImageCache;
/**
 *  提示功能未开放
 */
+(void)noticeUpdateOnWay;



@end
