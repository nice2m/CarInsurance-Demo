//
//  NewsTopHeaderModel.h
//  my-Project-Car
//
//  Created by 千锋 on 16/1/29.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsTopHeaderModel : NSObject


@property (nonatomic, assign) NSInteger TYPESETTING;

@property (nonatomic, assign) NSInteger liked;

@property (nonatomic, strong) NSArray *talks;

@property (nonatomic, assign) BOOL PUBLISH;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *duration;

@property (nonatomic, copy) NSString *CTIME;

@property (nonatomic, copy) NSString *imglink;

@property (nonatomic, copy) NSString *imglink_1;

@property (nonatomic, copy) NSString *imglink_2;

@property (nonatomic, copy) NSString *imglink_3;

@property (nonatomic, assign) NSInteger talkcount;

@property (nonatomic, assign) NSInteger readarts;

@property (nonatomic, assign) BOOL DELFLAG;

@property (nonatomic, copy) NSString *sourcename;

@property (nonatomic, assign) NSInteger likecount;

@property (nonatomic, assign) BOOL OPENSOURCE;

@property (nonatomic, assign) NSInteger SORT;

@property (nonatomic, assign) NSInteger recommond;

@property (nonatomic, copy) NSString *content168;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, assign) NSInteger faved;

@property (nonatomic, copy) NSString *TYPE;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *videolink;

@property (nonatomic, copy) NSString *author;

@property (nonatomic, copy) NSString *titlespelling;

/** 传入数据  返回model 数组*/
+(NSMutableArray *)topHeaderModelsWithDictionary:(NSDictionary *)dict;

@end
