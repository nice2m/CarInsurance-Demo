//
//  NewsViewController.m
//  my-Project-Car
//
//  Created by 千锋 on 16/1/28.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray * arr = @[@"车闻头条",
                      @"车险讯息",
                      @"用车经验"];
    [self createNaviBarItemWithTitles:arr];
//    
//    NSArray *array = [UIFont familyNames];
//    for  (NSString * familyname in array) {
//        NSLog(@"Family:%@" ,familyname);
//        NSArray *fontnames = [UIFont fontNamesForFamilyName:familyname];
//        for  (NSString *name in fontnames) {
//            NSLog(@"-----Font Name:%@" ,name);
//        }  
//    }
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
