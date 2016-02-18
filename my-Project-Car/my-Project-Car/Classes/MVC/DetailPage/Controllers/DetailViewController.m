//
//  DetailViewController.m
//  my-Project-Car
//
//  Created by 千锋 on 16/1/28.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import "DetailViewController.h"
#import "ShowImagesPageViewController.h"
#import <UMSocial.h>

@interface DetailViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate,UMSocialUIDelegate>

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
    
    //工具条上面的按钮
    UIButton * _favBtn;
    UIButton * _recommendBtn;
    UIButton * _messageBtn;
    UIButton * _shareBtn;
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
   
    _favBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _favBtn.frame = CGRectMake(0, 0, 40, 40);
    [_favBtn addTarget:self action:@selector(favPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_favBtn setImage:[UIImage imageNamed:@"fav_1"]forState:UIControlStateNormal];
    [_favBtn setImage:[UIImage imageNamed:@"fav_2"] forState:UIControlStateSelected];
    naviItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_favBtn];
    
    
    
    CGFloat btnW = kSCREEN_SIZE.width / 5 ;
    _recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _recommendBtn.frame = CGRectMake(0, 0, btnW, 60);
    
    
    UIImage * imgNor = [UIImage imageNamed:@"recommend"];
    UIImage * imgSel = [UIImage imageNamed:@"recommend_1"];
    [_recommendBtn setImage:imgNor forState:UIControlStateNormal];
    [_recommendBtn setImage:imgSel forState:UIControlStateSelected];
    [_recommendBtn addTarget:self action:@selector(recommendPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * firstItem = [[UIBarButtonItem alloc]initWithCustomView:_recommendBtn];
    
    _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _messageBtn.frame = CGRectMake(0, 0, btnW, 40);
    
    UIImage *imgnor1 = [UIImage imageNamed:@"message"];
    [_messageBtn setImage:imgnor1 forState:UIControlStateNormal];
    [_messageBtn addTarget:self action:@selector(messagePressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * secondItem = [[UIBarButtonItem alloc]initWithCustomView:_messageBtn];
    
    _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage * imgNor2 = [UIImage imageNamed:@"share"];
    [_shareBtn setImage: imgNor2 forState:UIControlStateNormal];
    [_shareBtn addTarget:self action:@selector(sharePressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * thirdItem = [[UIBarButtonItem alloc]initWithCustomView:_shareBtn];
    _shareBtn.frame = CGRectMake(0, 0, btnW, 40);
    _shareBtn.enabled = NO;
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
    
    _shareBtn.enabled = YES;
    
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
    
    //[Utils noticeUpdateOnWay];
    
    NSString * shareString = [NSString stringWithFormat:@"%@小伙伴围观：%@",[_webView stringByEvaluatingJavaScriptFromString:@"document.title"],_url];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UMSOCIAL_APP_KEY
                                      shareText:shareString
                                     shareImage:nil
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToWechatTimeline,UMShareToRenren,UMShareToDouban,UMShareToEmail,nil]
                                       delegate:self];
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


#pragma mark - UMengSocialDelegate

-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData{
    
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response{
    if (response.responseCode == UMSResponseCodeSuccess) {
        [SVProgressHUD showInfoWithStatus:@"分享成功！"];
    }else{
        [SVProgressHUD showErrorWithStatus:@"分享失败，请重试"];
    }
}
@end


















