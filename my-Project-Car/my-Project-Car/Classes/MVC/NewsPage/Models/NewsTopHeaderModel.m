//
//  NewsTopHeaderModel.m
//  my-Project-Car
//
//  Created by 千锋 on 16/1/29.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import "NewsTopHeaderModel.h"

@implementation NewsTopHeaderModel

+(NSMutableArray *)topHeaderModelsWithDictionary:(NSDictionary *)dict{
    NSMutableArray * modelsRS =[NSMutableArray array];
    NSArray *dataArr = dict[@"root"][@"list"];
    for (NSDictionary * dictTemp in dataArr) {
        NewsTopHeaderModel * model = [NewsTopHeaderModel new];
        [model setValuesForKeysWithDictionary:dictTemp];
        [modelsRS addObject:model];
    }
    return modelsRS;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
   // NSLog(@"undefined key:\n %@ = %@\tID = %ld",key,value,_ID);
}

@end
