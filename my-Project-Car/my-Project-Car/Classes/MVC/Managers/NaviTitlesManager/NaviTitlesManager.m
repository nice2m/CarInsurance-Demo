//
//  NaviTitlesManager.m
//  my-Project-Car
//
//  Created by 千锋 on 16/1/29.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import "NaviTitlesManager.h"

@implementation NaviTitlesManager


+(instancetype)sharedManager{
    static NaviTitlesManager * manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[NaviTitlesManager alloc]init];
    });
    return manager;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        [self makedata];
    }
    return self;
}

-(void)makedata{
    _newsNaviRequestTitles = @[@"汽车头条",@"车险资讯",@"用车指南"];
    _insuranceRequestTitles = @[@"车险超市",@"车险计算"];
    _priceRequestTitles = @[@"新车报价",@"二手好车"];
}

@end
