//
//  DetailViewController.h
//  my-Project-Car
//
//  Created by 千锋 on 16/1/28.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NJKWebViewProgress.h>
#import <NJKWebViewProgress/NJKWebViewProgressView.h>

@interface DetailViewController : UIViewController

/**
 *  详情URL地址
 */
@property(nonatomic,copy)NSString * url;

@property(nonatomic,copy)NSURLRequest * request;


@end
