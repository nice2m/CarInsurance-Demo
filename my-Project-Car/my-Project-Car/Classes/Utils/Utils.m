//
//  Utils.m
//  my-Project-Car
//
//  Created by ntms on 16/1/30.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+(NSString *)pastTimeDescWithString:(NSString *)aString{
    //NSDate * date1 = [NSDate dateWithTimeIntervalSince1970:1454119204000];
    if (aString != nil) {
        NSDate * dateNow = [NSDate date];
        NSDateFormatter  * forma = [ NSDateFormatter new];
        [forma setTimeZone:[NSTimeZone systemTimeZone]];
        [forma setDateFormat:@"yyyy-mm-dd HH:mm:ss"];
        NSDate * datePub = [forma dateFromString:aString];
        //取出两个日期的秒差
        NSTimeInterval timeInterval = [dateNow timeIntervalSinceDate:datePub];
        NSInteger daySeconds = 3600 * 24;
        NSString * stringRS = nil;
        NSInteger dayCnt = timeInterval / daySeconds;
        NSInteger weekCnt = timeInterval / daySeconds * 7;
        if (dayCnt == 0) {
            NSInteger hourCnt = timeInterval / 3600;
            if (hourCnt == 0) {
                stringRS = [NSString stringWithFormat:@"刚刚"];
            }else{
                stringRS = [NSString stringWithFormat:@"%.0f 小时前",timeInterval / 3600];
            }
        }else {
            if (dayCnt < 7) {
                stringRS = [NSString stringWithFormat:@"%ld 天前",dayCnt];
            }else{
                if (weekCnt < 4) {
                    stringRS = [NSString stringWithFormat:@"%ld 周前",weekCnt];
                }else{
                    stringRS = @"很久以前";
                }
                
            }
            
        }
        return stringRS;
    }
    return nil;
}
+(void)networkStartRefreshing{
    if ([UIApplication sharedApplication].networkActivityIndicatorVisible == NO) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
}

+(void)networkStopRefreshing{
    if ([UIApplication sharedApplication].networkActivityIndicatorVisible) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}

+(CGFloat)getSDWebImageCacheSize{
    
    SDImageCache * imgCache = [SDImageCache sharedImageCache];
    
    CGFloat diskSize = [imgCache getSize] / 8.f / 1024.f / 1024.f;
    
    return diskSize;
}

+(void)clearSDWebImageCache{
    SDImageCache * imgCache = [SDImageCache sharedImageCache];
   
    [imgCache clearDisk];
}

+(void)noticeUpdateOnWay{
    [SVProgressHUD showInfoWithStatus:@"介个功能陆续开发中，敬请期待"];
}

+(void)noticeNetworkError{
    [SVProgressHUD showErrorWithStatus:@"加载失败,您的网络粗错啦"];
}
@end
