//
//  BaseViewController.h
//  my-Project-Car
//
//  Created by 千锋 on 16/1/28.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
/**
 *  装按钮的数组
 */
@property(nonatomic,strong)NSMutableArray * btnsArr;


/**
 *  自定义navitationItem
 *
 *  @param nameArr 标题名字数组
 */
-(void)createNaviBarItemWithTitles:(NSArray *)nameArr;
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


@end
