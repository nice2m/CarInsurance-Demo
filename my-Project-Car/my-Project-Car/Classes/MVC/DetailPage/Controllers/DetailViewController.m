//
//  DetailViewController.m
//  my-Project-Car
//
//  Created by 千锋 on 16/1/28.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createUI{
    
    //设置标题文本
    UILabel * label = [[ UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    label.text = @"加载中…";
    self.navigationItem.titleView = label;
    
    //设置左边按钮颜色
    UINavigationItem * naviItem = self.navigationItem;
    UIButton * btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(0, 0, 30, 40);
    [btnBack setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(backPressed:) forControlEvents:UIControlEventTouchUpInside];
    naviItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btnBack];
    
    
    UIButton  * favBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    favBtn.frame = CGRectMake(0, 0, 40, 40);
    [favBtn addTarget:self action:@selector(favPressed:) forControlEvents:UIControlEventTouchUpInside];
    [favBtn setImage:[UIImage imageNamed:@"fav_1"]forState:UIControlStateNormal];
    [favBtn setImage:[UIImage imageNamed:@"fav_2"] forState:UIControlStateSelected];
    naviItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:favBtn];
    
    
    CGFloat btnW = kSCREEN_SIZE.width / 5 ;
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, btnW, 40);
    
    UIImage * imgNor = [UIImage imageNamed:@"recommend"];
    UIImage * imgSel = [UIImage imageNamed:@"recommend_1"];
    [btn setImage:imgNor forState:UIControlStateNormal];
    [btn setImage:imgSel forState:UIControlStateSelected];
    UIBarButtonItem * firstItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, btnW, 40);
    
    UIImage *imgnor1 = [UIImage imageNamed:@"message"];
    [btn1 setImage:imgnor1 forState:UIControlStateNormal];
    UIBarButtonItem * secondItem = [[UIBarButtonItem alloc]initWithCustomView:btn1];
    
    UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage * imgNor2 = [UIImage imageNamed:@"share"];
    [btn2 setImage: imgNor2 forState:UIControlStateNormal];
    UIBarButtonItem * thirdItem = [[UIBarButtonItem alloc]initWithCustomView:btn2];
    btn2.frame = CGRectMake(0, 0, btnW, 40);
    //btn2.frame = btn.frame;
    //self.toolbarItems = @[firstItem];
    //显示ToolBar
    self.navigationController.toolbarHidden = NO;
    
    //self.navigationController.toolbar.barTintColor = [UIColor orangeColor];
    
    //填充flexiable item 来布局 排版对齐方式
    UIBarButtonItem * fix1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem * fix2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    [self setToolbarItems:@[fix1,firstItem,secondItem,thirdItem,fix2] animated:NO];
}


#pragma mark - selector

-(void)backPressed:(UIButton *)sender{
    NSLog(@"返回点击");
}

-(void)favPressed:(UIButton *)sender{
    sender.selected = !sender.isSelected;
    NSLog(@"右侧按钮点击");
}

@end
