//
//  InsuranceViewController.h
//  my-Project-Car
//
//  Created by 千锋 on 16/1/28.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface InsuranceViewController : BaseViewController<UIWebViewDelegate,UIScrollViewDelegate>
/**
 *  请求地址
 */
@property(nonatomic,copy)NSString * firstUrl;
/**
 *  第二个请求地址
 */
@property(nonatomic,copy)NSString * secondUrl;
/**
 *  容器滚动视图
 */
@property(nonatomic,strong)UIScrollView * containerScrollView;
/**
 *  网页视图 1
 */
@property(nonatomic,strong)UIWebView * webViewFirst;
/**
 *  网页视图 2
 */
@property(nonatomic,strong)UIWebView * webViewSecond;
/**
 *  网页视图1 能否后退
 */
@property(nonatomic,copy)NSString * firstCanGoBack;
/**
 *  网页视图2 能否后退
 */
@property(nonatomic,copy)NSString * secondCanGoBack;
/**
 *  后退按钮
 */
@property(nonatomic,strong)UIButton * backBtn;

/**
 *  创建网页视图
 */
-(void)createNJKWebView;
/**
 *  单击按钮显示上一页WebView内容
 *
 *  @param sender 被点击的按钮
 */
-(void)backBtnPressed:(UIButton *)sender;

/**
 *  第一个网页视图 返回方法
 */
-(void)firstWebViewGoBack;

/**
 *  第二个网页视图 返回方法
 */
-(void)secondWebViewGoBack;
/**
 *  设置监听
 */
-(void)setupObserver;

@end
