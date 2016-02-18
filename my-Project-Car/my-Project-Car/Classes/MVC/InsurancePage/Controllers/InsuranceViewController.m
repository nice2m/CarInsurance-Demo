//
//  InsuranceViewController.m
//  my-Project-Car
//
//  Created by 千锋 on 16/1/28.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import "InsuranceViewController.h"

@implementation InsuranceViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray * arr = @[@"简易车险",@"车险助手"];
    self.firstUrl = INSURANCE_API_FIRST_REQUEST;
    self.secondUrl = INSURANCE_API_SECOND_REQUEST;
    //[self createNaviBarItemWithTitles:arr];
    self.titleArray = arr;
    UIButton * btn = (UIButton *)self.btnsArr[0];
    btn.selected = YES;
    
    [self createNJKWebView];
    [self.navigationController.view addSubview:self.backBtn];
    self.view.backgroundColor = [UIColor greenColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)dealloc{
    [self removeObserver:self forKeyPath:@"firstCanGoBack"];
    [self removeObserver:self forKeyPath:@"secondCanGoBack"];
}
#pragma mark - lazily load

-(UIWebView *)webViewFirst{
    if (_webViewFirst == nil ) {
        _webViewFirst = [UIWebView new];
        _webViewFirst.delegate = self;
    }
    return _webViewFirst;
}

-(UIWebView *)webViewSecond{
    if (_webViewSecond == nil) {
        _webViewSecond = [UIWebView new];
        _webViewSecond.delegate = self;
    }
    return _webViewSecond;
}

-(UIButton *)backBtn{
    if (_backBtn == nil ) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"goBack"] forState:UIControlStateNormal];
        [_backBtn setImage:[UIImage imageNamed:@"goBack"] forState:UIControlStateHighlighted];
        CGSize size = _backBtn.currentImage.size;
        CGFloat btnX = CGRectGetMaxX(self.view.frame) - size.width - 8;
        CGFloat btnY = CGRectGetMinY(self.tabBarController.tabBar.frame) - size.height - 8;
        _backBtn.frame = CGRectMake(btnX, btnY, size.width , size.height);
        [_backBtn addTarget:self action:@selector(backBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        //第一次进入 隐藏按钮
        _backBtn.hidden = YES;
    }
    return _backBtn;
}
#pragma mark - UI
/**
 *  scrollView 中装入两个UIWebView
 */
-(void)createNJKWebView{
    //ScrollView
    self.containerScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -64, kSCREEN_SIZE.width, kSCREEN_SIZE.height)];
    self.containerScrollView.contentSize = CGSizeMake(self.containerScrollView.frame.size.width * 2 , self.containerScrollView.frame.size.height - 64 - 49);
    self.containerScrollView.contentSize = CGSizeMake(self.containerScrollView.frame.size.width * 2 , self.containerScrollView.frame.size.height - 64 - 49);

    [self.view addSubview:self.containerScrollView];
    self.containerScrollView.delegate = self;
    self.containerScrollView.pagingEnabled = YES;
    self.containerScrollView.backgroundColor = [UIColor whiteColor];
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
    
    //self.containerScrollView.backgroundColor = [UIColor redColor];
    [self setupObserver];
    
}




#pragma mark - WebViewDelegate

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [Utils networkStopRefreshing];
    if ([webView isEqual:self.webViewFirst]) {
        self.firstCanGoBack =[NSString stringWithFormat:@"%u",arc4random()];
    }else{
        self.secondCanGoBack = [NSString stringWithFormat:@"%u",arc4random()];
    }
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//#warning notice!!! expect error handler
    [Utils networkStopRefreshing];
    [Utils noticeNetworkError];
    NSLog(@"%s\t加载失败",__func__);
    if ([webView isEqual:self.webViewFirst]) {
        self.firstCanGoBack =[NSString stringWithFormat:@"%u",arc4random()];
    }else{
        self.secondCanGoBack = [NSString stringWithFormat:@"%u",arc4random()];
    }
}


//即将开始跳转
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    [Utils networkStartRefreshing];
    return YES;
}


#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //修改导航条按钮状态
    if ([scrollView isEqual:self.containerScrollView]) {
        [self changeBtnsSelectedToNo];
        CGPoint offset = self.containerScrollView.contentOffset;
        NSInteger nowPage = offset.x / self.containerScrollView.frame.size.width;
        if (nowPage <self.btnsArr.count) {
            UIButton * btn = (UIButton *)self.btnsArr[nowPage];
            btn.selected = YES;
        }
    }
}

#pragma mark - Selector

-(void)firstBtnPressed:(UIButton *)sender{
    [self changeBtnsSelectedToNo];
    sender.selected = YES;
    CGPoint offset;
    offset.x = 0;
    offset.y = -64;
    self.containerScrollView.contentOffset = offset;
    
    //[self.webViewFirst reload];
}

-(void)secondBtnPressed:(UIButton *)sender{
    [self changeBtnsSelectedToNo];
    sender.selected = YES;
    CGPoint offset;
    offset.x = self.containerScrollView.frame.size.width;
    offset.y = -64;
    self.containerScrollView.contentOffset = offset;
    
    //[self.webViewSecond reload];
}

-(void)backBtnPressed:(UIButton *)sender{
    NSLog(@"%s\t返回按钮点击了",__func__);
    CGPoint offset = self.containerScrollView.contentOffset;
    NSInteger currentPage = offset.x / self.containerScrollView.frame.size.width;
    switch (currentPage) {
        case 0:
            [self firstWebViewGoBack];
            break;
        case 1:
            [self secondWebViewGoBack];
            break;
        default:
            break;
    }
}

#pragma mark - KVO

-(void)setupObserver{
    [self addObserver:self forKeyPath:@"firstCanGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"secondCanGoBack" options:NSKeyValueObservingOptionNew context:nil];
}
//监听是否显示返回按钮
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"firstCanGoBack"]) {
        self.backBtn.hidden = ![self.webViewFirst canGoBack];
    }else if([keyPath isEqualToString:@"secondCanGoBack"]){
        self.backBtn.hidden = ![self.webViewSecond canGoBack];
    }
}

#pragma mark - Other
/**
 *
 */
-(void)firstWebViewGoBack{
    if ([self.webViewFirst canGoBack]) {
        [self.webViewFirst goBack];
    }
    //不管能否后退，发送通知 更新 self.backBtn 按钮的显示状态
    self.firstCanGoBack =[NSString stringWithFormat:@"%u",arc4random()];
}

-(void)secondWebViewGoBack{
    if ([self.webViewSecond canGoBack]) {
        [self.webViewSecond goBack];
    }
    //不管能否后退，发送通知 更新 self.backBtn 按钮的显示状态
    self.secondCanGoBack = [NSString stringWithFormat:@"%u",arc4random()];
}

@end
