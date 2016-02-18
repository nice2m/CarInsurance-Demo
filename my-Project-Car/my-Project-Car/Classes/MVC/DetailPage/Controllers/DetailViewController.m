//
//  DetailViewController.m
//  my-Project-Car
//
//  Created by 千锋 on 16/1/28.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import "DetailViewController.h"
#import "ShowImagesPageViewController.h"

@interface DetailViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>

@property(nonatomic,strong)UIWebView * webView;


@end

@implementation DetailViewController

{
    // 代理管理类
    NJKWebViewProgress * _webViewProgerss ;
    //代理的视图
    NJKWebViewProgressView * _webViewProgerssView;
    
    //titleView
    //UILabel * _naviTitleLabel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
    [self createNJKWebView];
    
}


-(void)viewWillDisappear:(BOOL)animated{
    [_webViewProgerssView removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createUI{
    //设置标题文本
    UILabel * _naviTitleLabel = [UILabel new];
    _naviTitleLabel.font = [UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:18];
    _naviTitleLabel.textColor = [UIColor whiteColor];
    _naviTitleLabel.text = @"详 情";
    CGSize size = [_naviTitleLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:18]}];
    _naviTitleLabel.frame =CGRectMake(0, 0, size.width, size.height);
    _naviTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = _naviTitleLabel;
    
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
    btn.frame = CGRectMake(0, 0, btnW, 60);
    
    UIImage * imgNor = [UIImage imageNamed:@"recommend"];
    UIImage * imgSel = [UIImage imageNamed:@"recommend_1"];
    [btn setImage:imgNor forState:UIControlStateNormal];
    [btn setImage:imgSel forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(recommendPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * firstItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, btnW, 40);
    
    UIImage *imgnor1 = [UIImage imageNamed:@"message"];
    [btn1 setImage:imgnor1 forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(messagePressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * secondItem = [[UIBarButtonItem alloc]initWithCustomView:btn1];
    
    UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage * imgNor2 = [UIImage imageNamed:@"share"];
    [btn2 setImage: imgNor2 forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(sharePressed:) forControlEvents:UIControlEventTouchUpInside];
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
    
    //webView
//    _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
//    [self.view addSubview:_webView];
//    NSURLRequest * request = _url?[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]:_request;
//    _webView.delegate = self;
//    [_webView loadRequest:request];
}


#pragma mark - UIWebViewDelegate

-(void)webViewDidFinishLoad:(UIWebView *)webView{
//    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
//    lab.textAlignment = NSTextAlignmentCenter;
//    lab.text = @"详 情";
//    lab.font = [UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:18];
//    lab.textColor = [UIColor whiteColor];
//    self.navigationItem.titleView =lab;
    //停止小菊花
    [Utils networkStopRefreshing];
    //禁用长按弹出菜单
    UILongPressGestureRecognizer * gs = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:nil];
    gs.minimumPressDuration  = 0.4;
    [webView addGestureRecognizer:gs];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //开启小菊花
    [Utils networkStartRefreshing];
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        NSString * urlID = [[request URL] absoluteString];
        urlID = [urlID componentsSeparatedByString:@"id="].lastObject;
        NSString * newRequestStr = [NSString stringWithFormat:NEWS_API_ARTICAL_DETAIL_FORMATTED,[urlID integerValue]];
        DetailViewController * detailVC = [DetailViewController new];
        detailVC.url = newRequestStr;
        [self.navigationController pushViewController:detailVC animated:YES];
        return NO;
    }
        // NSLog(@"%@",path);
    return YES;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    //关闭小菊花
    [Utils networkStopRefreshing];
    [SVProgressHUD showErrorWithStatus:@"您的网络开小差啦"];
    NSLog(@"webviewError:%@",error.localizedDescription);
}

#pragma mark - selector

-(void)backPressed:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)favPressed:(UIButton *)sender{
    [Utils noticeUpdateOnWay];
    NSLog(@"右侧按钮点击");
}
-(void)recommendPressed:(UIButton *) sender{
    [Utils noticeUpdateOnWay];
}

-(void)messagePressed:(UIButton *)sender{
    [Utils noticeUpdateOnWay];
}

-(void)sharePressed:(UIButton *)sender{
    [Utils noticeUpdateOnWay];
}
#pragma mark - NJKWebViewDelegate

-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress{
    
    [_webViewProgerssView setProgress:progress animated:YES];
//    if ([_naviTitleLabel.text isEqualToString:@"加 载 中…"]) {
//        _naviTitleLabel.text = nil;
//    }
//    _naviTitleLabel.text = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

#pragma  mark - Other

-(void)createNJKWebView{
    _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
    _webViewProgerss = [[NJKWebViewProgress alloc]init];
    
    _webView.delegate = _webViewProgerss;
    _webViewProgerss.webViewProxyDelegate = self;
    _webViewProgerss.progressDelegate = self;
    
    CGRect naviBounds = self.navigationController.navigationBar.bounds;
    CGRect progressRect = CGRectMake(0, naviBounds.size.height - 2, naviBounds.size.width, 2);
    
    _webViewProgerssView = [[NJKWebViewProgressView alloc]initWithFrame:progressRect];
    _webViewProgerssView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_webViewProgerssView setProgress:0 animated:YES];
    [self.navigationController.navigationBar addSubview:_webViewProgerssView];
    NSURLRequest * request = _url?[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]:_request;
    [_webView loadRequest:request];
}


@end


















