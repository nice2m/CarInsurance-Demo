//
//  PriceViewController.m
//  my-Project-Car
//
//  Created by 千锋 on 16/1/28.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import "PriceViewController.h"

@interface PriceViewController ()

@end

@implementation PriceViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray * arr = @[@"热门报价",@"爱车转让"];
    self.firstUrl = PRICE_API_FIRST_REQUEST;
    self.secondUrl = PRICE_API_SECOND_REQUEST;
    //[self createNaviBarItemWithTitles:arr];
    self.titleArray = arr;
    UIButton * btn = (UIButton *)self.btnsArr[0];
    btn.selected = YES;
    
    [self createNJKWebView];
    [self.navigationController.view addSubview:self.backBtn];
    [self setupObserver];
}

-(void)createNJKWebView{
    //self.containerScrollView.showsHorizontalScrollIndicator = YES;
    //ScrollView
    self.containerScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_SIZE.width, kSCREEN_SIZE.height)];
    self.containerScrollView.contentSize = CGSizeMake(self.containerScrollView.frame.size.width * 2 , self.containerScrollView.frame.size.height - 64 - 49);
    self.containerScrollView.contentSize = CGSizeMake(self.containerScrollView.frame.size.width * 2 , self.containerScrollView.frame.size.height - 64 - 49);
    self.containerScrollView.backgroundColor = [UIColor whiteColor];
    
    
    [self.view addSubview:self.containerScrollView];
    self.containerScrollView.delegate = self;
    self.containerScrollView.pagingEnabled = YES;
    
    //webView 1
    //    self.webViewFirst.frame = self.containerScrollView.bounds;
    self.webViewFirst.frame = CGRectMake(0, 64, self.containerScrollView.frame.size.width, self.containerScrollView.frame.size.height - 64 - 49);
    [self.containerScrollView addSubview:self.webViewFirst];
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.firstUrl]];
    [self.webViewFirst loadRequest:request];
    
    //webView 2
    [self.containerScrollView addSubview:self.webViewSecond];
    self.webViewSecond.frame = CGRectMake(self.containerScrollView.frame.size.width, 64, self.containerScrollView.frame.size.width, self.containerScrollView.frame.size.height - 64 - 49);
    NSURLRequest * request2 = [NSURLRequest requestWithURL:[NSURL URLWithString:self.secondUrl]];
    [self.webViewSecond loadRequest:request2];
}


#pragma mark - Selector

-(void)firstBtnPressed:(UIButton *)sender{
    [self changeBtnsSelectedToNo];
    sender.selected = YES;
    CGPoint offset;
    offset.x = 0;
    offset.y = 0;
    self.containerScrollView.contentOffset = offset;
    
    //[self.webViewFirst reload];
}

-(void)secondBtnPressed:(UIButton *)sender{
    [self changeBtnsSelectedToNo];
    sender.selected = YES;
    CGPoint offset;
    offset.x = self.containerScrollView.frame.size.width;
    offset.y = 0;
    self.containerScrollView.contentOffset = offset;
    
    //[self.webViewSecond reload];
}

#pragma mark - KVO
-(void)setupObserver{
    [self addObserver:self forKeyPath:@"secondCanGoBack" options:NSKeyValueObservingOptionNew context:nil];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"firstCanGoBack"]) {
        self.backBtn.hidden = ![self.webViewFirst canGoBack];
    }else if([keyPath isEqualToString:@"secondCanGoBack"]){
        self.backBtn.hidden = ![self.webViewSecond canGoBack];
    }
}
@end
