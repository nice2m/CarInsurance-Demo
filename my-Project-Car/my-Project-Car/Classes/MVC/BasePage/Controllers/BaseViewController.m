//
//  BaseViewController.m
//  my-Project-Car
//
//  Created by 千锋 on 16/1/28.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.navigationController.navigationBar.backgroundColor = [UIColor orangeColor];
    //初始化数组
    self.btnsArr = [NSMutableArray array];
    //设置navigationBar 背景颜色
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.29 green:0.35 blue:0.5 alpha:1];
    //NSArray * arr = @[@"汽车头条",@"车险资讯"];
    //定制navigationBar
    //[self createNaviBarItemWithTitles:arr];
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

#pragma mark - Method


-(void)createNaviBarItemWithTitles:(NSArray *)nameArr{
    
    UINavigationItem * naviItem = self.navigationItem;
    CGFloat btnW = kSCREEN_SIZE.width / 4;
    CGFloat btnH = 40;
    CGRect btnframe = CGRectMake(0, 0, btnW, btnH);
    switch (nameArr.count) {
        case 2:
        {
            //btnW *=2;
            btnframe = CGRectMake(0, 0, btnW *2, btnH);
            //自定义按钮
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            //添加点击事件
            [btn addTarget:self action:@selector(firstBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            [btn setTitle:nameArr[0] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            btn.frame = btnframe;
            UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:btn];

            naviItem.leftBarButtonItem = leftItem;
            UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
            //添加点击事件
            [btn1 addTarget:self action:@selector(secondBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            [btn1 setTitle:nameArr[1] forState:UIControlStateNormal];
            [btn1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            
            UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn1];
            naviItem.rightBarButtonItem = rightItem;
            btn1.frame = btnframe;
            //naviItem.titleView =
            //装入数组 方便调用
            [_btnsArr addObject:btn];
            [_btnsArr addObject:btn1];
        }
            break;
            
        case 3:
        {
            
            //自定义按钮
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            //添加点击事件
            [btn addTarget:self action:@selector(firstBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:nameArr[0] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            btn.frame = btnframe;
            //[btn sizeToFit];
            UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
            
            UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
            //添加点击事件
            [btn1 addTarget:self action:@selector(secondBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            [btn1 setTitle:nameArr[1] forState:UIControlStateNormal];
            [btn1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            
            btn1.frame = btnframe;
            //btn1.frame = CGRectMake(60, 0, 60, 40);
            //UIBarButtonItem * centerItem = [[UIBarButtonItem alloc]initWithCustomView:btn1];
            
            
            //UIView * v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
            //v.backgroundColor = [UIColor redColor];
            
            //naviItem.titleView.userInteractionEnabled = YES;
            //btn1.frame = CGRectMake(50, 5, 60, 40);
            naviItem.titleView = btn1;
            
            UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
            //添加点击事件
            [btn2 addTarget:self action:@selector(thirdBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            [btn2 setTitle:nameArr[2] forState:UIControlStateNormal];
            //[btn2 setTitle:nameArr[2] forState:UIControlStateNormal];
            [btn2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            
            UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn2];
            btn2.frame = btnframe;
            
            naviItem.leftBarButtonItem = leftItem;
            naviItem.titleView = btn1;
            naviItem.rightBarButtonItem = rightItem;
            
            [_btnsArr addObject:btn];
            [_btnsArr addObject:btn1];
            [_btnsArr addObject:btn2];        }
            break;
        default:
        {
            NSLog(@"测试switch-default");
            NSException * exc = [NSException exceptionWithName:@"Error:" reason:@"标题数组的count 应该大于1" userInfo:nil];
            @throw exc;
        }
            break;
    }
}

-(void)firstBtnPressed:(UIButton *)sender{
    sender.selected = !sender.isSelected;
}

-(void)secondBtnPressed:(UIButton *)sender{
    sender.selected = !sender.isSelected;
}

-(void)thirdBtnPressed:(UIButton *)sender{
    sender.selected = !sender.isSelected;
}
                                              
@end
