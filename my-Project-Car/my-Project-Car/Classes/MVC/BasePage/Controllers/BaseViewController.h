//
//  BaseViewController.h
//  my-Project-Car
//
//  Created by 千锋 on 16/1/28.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>
#import <NJKWebViewProgress.h>
#import <NJKWebViewProgress/NJKWebViewProgressView.h>

@interface BaseViewController : UIViewController
/**
 *  按钮标题数组
 */
@property(nonatomic,strong)NSArray * titleArray;
/**
 *  自身所有按钮的数组
 */
@property(nonatomic,strong)NSArray * btnsArr;
/**
 *  自定义navitationItem
 *
 *  @param nameArr 标题名字数组
 */
//-(void)createNaviBarItemWithTitles:(NSArray *)nameArr;
/**
 *  第一个按钮点击事件
 */
-(void)firstBtnPressed:(UIButton *)sender;
/**
 *  第二个按钮点击事件
 */
-(void)secondBtnPressed:(UIButton *)sender;
/**
 *  第三个按钮点击事件
 */
-(void)thirdBtnPressed:(UIButton *)sender;
/**
 *  返回按钮点击
 */
-(void)backBtnPressed:(UIButton *)sender;
/**
 *  改变所有的按钮位非选中状态
 */
-(void)changeBtnsSelectedToNo;

@end
