//
//  NaviTitlesManager.h
//  my-Project-Car
//
//  Created by 千锋 on 16/1/29.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NaviTitlesManager : NSObject

@property(nonatomic,strong)NSArray * newsNaviRequestTitles;

@property(nonatomic,strong)NSArray * insuranceRequestTitles;

@property(nonatomic,strong)NSArray * priceRequestTitles;

/**
 *  单例方法
 */
+(instancetype)sharedManager;

@end
