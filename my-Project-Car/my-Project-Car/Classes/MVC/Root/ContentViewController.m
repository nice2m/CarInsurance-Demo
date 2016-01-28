//
//  ContentViewController.m
//  my-Project-Car
//
//  Created by 千锋 on 16/1/28.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //定制tabController 的 barItem
    //NSLog(@"self.childViews:%@",self.childViewControllers);
    
    NSArray * arrTitle = @[@"主页",
                           @"车险助理",
                           @"车市风向"];
    NSArray * imageNames = @[@"news_nor",@"insurance_nor",@"price_chart_nor"];
    NSArray * imageNamesHL = @[@"news_hl",@"insurance_hl",@"price_chart_hl"];
    NSArray * childVC = self.childViewControllers;
    for (int i = 0 ; i < childVC.count; i ++) {
        UIViewController * v = childVC[i];
        UITabBarItem * item = v.tabBarItem;
        UIImage * norImg = [[UIImage imageNamed:imageNames[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage * hlImg = [[UIImage imageNamed:imageNamesHL[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //UIImage * norImg = [UIImage imageNamed:imageNames[i]];
        //UIImage * hlImg = [UIImage imageNamed:imageNames[i]];
        [item setImage:norImg];
        [item setSelectedImage:hlImg];
//        item.titlePositionAdjustment
        item.title = arrTitle[i];
        //设置TabBarItem 字体颜色，字体
        NSMutableDictionary * hlAttr = [NSMutableDictionary dictionary];
        hlAttr[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.07 green:0.62 blue:1 alpha:1];
        //FZLanTingHeiS-L-GB FZLTXIHJW--GB1-0
        //hlAttr[NSFontAttributeName] = [UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:14];
        hlAttr[NSFontAttributeName] = [UIFont systemFontOfSize:12 weight:UIFontWeightBold];
        [item setTitleTextAttributes: hlAttr forState:UIControlStateHighlighted];
        
        NSMutableDictionary * norAttr = [NSMutableDictionary dictionary];
        norAttr[NSForegroundColorAttributeName] = [UIColor grayColor];
        norAttr[NSFontAttributeName] = [UIFont systemFontOfSize:12];
        [item setTitleTextAttributes:norAttr forState:UIControlStateNormal];
    }
    
    UIView *bgView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    bgView.backgroundColor = [UIColor colorWithRed:0.74 green:0.74 blue:0.74 alpha:1];
    [self.tabBar insertSubview:bgView atIndex:0];
    self.tabBar.opaque = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
