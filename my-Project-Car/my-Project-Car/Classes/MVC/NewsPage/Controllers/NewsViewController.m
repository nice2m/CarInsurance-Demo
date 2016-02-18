//
//  NewsViewController.m
//  my-Project-Car
//
//  Created by 千锋 on 16/1/28.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsTopHeaderModel.h"
#import "NewsTopHeaderCell.h"
#import "NewsInfoViewCell.h"
#import "NewsInfoViewCellNoImg.h"
#import "NewsExpViewCell.h"
#import "DetailViewController.h"

//ReuseId
static NSString * reuseID1 = @"NewsTopHeaderCell";
static NSString * reuseID2 = @"NewsInfoViewCell";
static NSString * reuseID3 = @"NewsInfoViewCellNoImg";
static NSString * reuseID4 = @"NewsExpViewCell";
static NSString * reuseID5 = @"NewsExpViewCellSingleImg";

@interface NewsViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

/**
 *  主要容器滚动视图
 */
@property(nonatomic,strong)UIScrollView * mainScrollView;
/**
 *  车闻头条tableView
 */
@property(nonatomic,strong)UITableView * topHeaderTableView;
/**
 *  车险讯息 tableView
 */
@property(nonatomic,strong)UITableView * infoOfInsuranceTableView;
/**
 *  用车经验 tableView
 */
@property(nonatomic,strong)UITableView * carExperienceTableView;
/**
 *  车闻头条数组
 */
@property(nonatomic,strong)NSMutableArray * topHeadersData;
/**
 *  车险讯息数组
 */
@property(nonatomic,strong)NSMutableArray * infoOfInsuranceData;
/**
 *  用车经验数组
 */
@property(nonatomic,strong)NSMutableArray * carExperienceData;


@end

@implementation NewsViewController

{
    //数据请求type= 后用到的字符 管理
    NaviTitlesManager * _titleManager;
    //页信息条数
    NSInteger _perPageContentCnt;
    
    //头条当前页
    __block NSInteger _topCurrentPage;
    //讯息当前页
    __block NSInteger _infoCurrentPage;
    //经验当前页
    __block NSInteger _expCurrentPage;
    
}
#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _titleManager = [NaviTitlesManager sharedManager];
    _topCurrentPage = 1;
    _perPageContentCnt = 20;
    
    NSArray * arr = @[@"车闻头条",
                      @"车险讯息",
                      @"用车经验"];
    
    self.titleArray = arr;
//    [self createNaviBarItemWithTitles:arr];
    
    //NSLog(@"mybuttons:%@",self.btnsArr);
    
    [self createUI];
    //[self requestData];
    [self firstLoad];
    
#pragma mark -  预览字体样式名字

//    NSArray *array = [UIFont familyNames];
//    for  (NSString * familyname in array) {
//        NSLog(@"Family:%@" ,familyname);
//        NSArray *fontnames = [UIFont fontNamesForFamilyName:familyname];
//        for  (NSString *name in fontnames) {
//            NSLog(@"-----Font Name:%@" ,name);
//        }  
//    }
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.toolbarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - lazily load

-(NSMutableArray *)topHeadersData{
    if (_topHeadersData  == nil) {
        _topHeadersData = [NSMutableArray array];
    }
    return _topHeadersData;
}

-(NSMutableArray *)infoOfInsuranceData{
    if (_infoOfInsuranceData == nil) {
        _infoOfInsuranceData = [NSMutableArray array];
    }
    return _infoOfInsuranceData;
}

-(NSMutableArray *)carExperienceData{
    if (_carExperienceData == nil) {
        _carExperienceData = [NSMutableArray array];
    }
    return _carExperienceData;
    
}

//-(UITableView *)carExperienceTableView{
//    if (_carExperienceTableView == nil) {
//        _carExperienceTableView = [UITableView new];
//        _carExperienceTableView.del
//    }
//    return _carExperienceTableView;
//}
//-(UITableView *)infoOfInsuranceTableView{
//    if (_infoOfInsuranceTableView == nil) {
//        _infoOfInsuranceTableView = [UITableView new];
//    }
//    return _infoOfInsuranceTableView;
//}
//
//-(UITableView *)topHeaderTableView{
//    if (_topHeaderTableView == nil ) {
//        _topHeaderTableView = [UITableView new];
//    }
//    return _topHeaderTableView;
//}

#pragma mark - UI

// 创建UI
-(void)createUI{
    self.view.backgroundColor = [UIColor orangeColor];
    //scrollView
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_SIZE.width, kSCREEN_SIZE.height)];
    
    _mainScrollView.backgroundColor = [UIColor whiteColor];
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.contentSize = CGSizeMake(_mainScrollView.frame.size.width * 3, _mainScrollView.frame.size.height - 64 - 49);
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.bounces = NO;
    _mainScrollView.delegate = self;
    [self.view addSubview:_mainScrollView];
    CGFloat tableHeight = _mainScrollView.frame.size.height;
    
    //tableViews
    _topHeaderTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_SIZE.width, tableHeight)];
    _topHeaderTableView.delegate = self;
    _topHeaderTableView.dataSource = self;
    _topHeaderTableView.tag = NEWS_TOPHEADER_TAG;
    [_mainScrollView addSubview:_topHeaderTableView];
    //NSLog(@"self.newsFrame:%@",NSStringFromCGRect(self.topHeaderTableView.frame));
    
    _infoOfInsuranceTableView = [[UITableView alloc]initWithFrame:CGRectMake(kSCREEN_SIZE.width, 0, kSCREEN_SIZE.width, tableHeight)];
    _infoOfInsuranceTableView.dataSource = self;
    _infoOfInsuranceTableView.delegate = self;
    _infoOfInsuranceTableView.tag = NEWS_INFOOFINSURE_TAG;
    [_mainScrollView addSubview:_infoOfInsuranceTableView];
    
    _carExperienceTableView = [[UITableView alloc]initWithFrame:CGRectMake(kSCREEN_SIZE.width * 2, 0, kSCREEN_SIZE.width, tableHeight)];
    [_mainScrollView addSubview:_carExperienceTableView];
    _carExperienceTableView.delegate = self;
    _carExperienceTableView.dataSource = self;
    _carExperienceTableView.tag = NEWS_CAREXPERIENCE_TAG;
    
    
    // nib 文件加载单元格
    [_topHeaderTableView registerNib:[UINib nibWithNibName:reuseID1 bundle:nil] forCellReuseIdentifier:reuseID1];
    [_infoOfInsuranceTableView registerNib:[UINib nibWithNibName:reuseID2 bundle:nil] forCellReuseIdentifier:reuseID2];
    [_infoOfInsuranceTableView registerNib:[UINib nibWithNibName:reuseID3 bundle:nil] forCellReuseIdentifier:reuseID3];
    [_carExperienceTableView registerNib:[UINib nibWithNibName:reuseID4 bundle:nil] forCellReuseIdentifier:reuseID4];
    [_carExperienceTableView registerNib:[UINib nibWithNibName:reuseID2 bundle:nil] forCellReuseIdentifier:reuseID5];
    
    
    //MJRefresh
    _topHeaderTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _topCurrentPage = 1;
        [self requestDataWithCurrentPage:_topCurrentPage andType:_titleManager.newsNaviRequestTitles[0] andIsFirst:NO];
    }];
    _topHeaderTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _topCurrentPage += 1;
        [self requestDataWithCurrentPage:_topCurrentPage andType:_titleManager.newsNaviRequestTitles[0] andIsFirst:NO];
    }];
    
    _infoOfInsuranceTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _infoCurrentPage = 1;
        [self requestDataWithCurrentPage:_infoCurrentPage andType:_titleManager.newsNaviRequestTitles[1] andIsFirst:NO];
    }];
    _infoOfInsuranceTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        _infoCurrentPage +=1;
        [self requestDataWithCurrentPage:_infoCurrentPage andType:_titleManager.newsNaviRequestTitles[1] andIsFirst:NO];
    }];
    
    _carExperienceTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _expCurrentPage = 1;
        [self requestDataWithCurrentPage:_expCurrentPage andType:_titleManager.newsNaviRequestTitles[2] andIsFirst:NO];
    }];
    _carExperienceTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        _expCurrentPage +=1;
        [self requestDataWithCurrentPage:_expCurrentPage andType:_titleManager.newsNaviRequestTitles[2] andIsFirst:NO];
    }];
    
    //附加按钮
    //[self.view addSubview:self.backBtn];
    
}

#pragma mark - Request data

-(void)requestDataWithCurrentPage:(NSInteger)currentPage andType:(NSString *)typeName andIsFirst:(BOOL)isFirst{
    //创建 AFHttpRequestManager
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    //manager
    NSString * requestTitle = [typeName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSInteger contentsCnt = _perPageContentCnt * currentPage;
    NSString * requestStr = [NSString stringWithFormat:NEWS_API_TOPHEADER_FORMATTERED,contentsCnt,requestTitle];
    [Utils networkStartRefreshing];
    [manager GET:requestStr parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        //接收响应字典
        NSDictionary * dict = (NSDictionary *)responseObject;
        //NSLog(@"responseObject:%@",responseObject);
        if ([typeName isEqualToString:_titleManager.newsNaviRequestTitles[0]]) {
            if (currentPage == 1) {
                self.topHeadersData = nil;
                //self.topHeaderTableView.mj_footer.hidden = YES;
                
            }
            self.topHeadersData  = [NewsTopHeaderModel  topHeaderModelsWithDictionary:dict];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (currentPage == 1) {
                    self.topHeaderTableView.mj_footer.hidden = YES;
                }
                [self dataCompletedWithTableTag:NEWS_TOPHEADER_TAG];
            });
            
        }else if([typeName isEqualToString:_titleManager.newsNaviRequestTitles[1]]){
            
            if (currentPage == 1) {
                self.infoOfInsuranceData = nil;
                
            }
            self.infoOfInsuranceData = [NewsTopHeaderModel topHeaderModelsWithDictionary:dict];
            if (!isFirst) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (currentPage == 1) {
                        self.infoOfInsuranceTableView.mj_footer.hidden = YES;
                    }
                    [self dataCompletedWithTableTag:NEWS_INFOOFINSURE_TAG];
                });
            }
        }else if([typeName isEqualToString:_titleManager.newsNaviRequestTitles[2]]){
            if (currentPage == 1) {
                self.carExperienceData = nil;
            }
            self.carExperienceData = [NewsTopHeaderModel topHeaderModelsWithDictionary:dict];
            if (!isFirst) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (currentPage == 1) {
                        self.carExperienceTableView.mj_footer.hidden = YES;
                    }
                    [self dataCompletedWithTableTag:NEWS_CAREXPERIENCE_TAG];
                });
            }
        }else{
            NSException * exc = [NSException exceptionWithName:@"error:" reason:@"服务器尚未添加的Type" userInfo:nil];
            @throw exc;
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (error) {
            //提示网络出错
            [Utils noticeNetworkError];
            NSLog(@"error:%@",error.localizedDescription);
            if ([typeName isEqualToString:_titleManager.newsNaviRequestTitles[0]]) {
                _topCurrentPage -=1;
                [Utils networkStopRefreshing];
            }else if([typeName isEqualToString:_titleManager.newsNaviRequestTitles[1]]){
                _infoCurrentPage -=1;
                //[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                [Utils networkStopRefreshing];
            }else if([typeName isEqualToString:_titleManager.newsNaviRequestTitles[2]]){
                _expCurrentPage -= 1;
                [Utils networkStopRefreshing];
            }
        }
    }];
}
//数据加载完成时调用
-(void)dataCompletedWithTableTag:(NSInteger)tag{
    //停止小菊花 旋转
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    UITableView * tableV = [self.view viewWithTag:tag];
    if (tableV != nil) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
    }
    [tableV reloadData];
}

#pragma mark - UITableViewDelegate

//
//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 400;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_topHeaderTableView]) {
        return 360;
    }else if([tableView isEqual:_infoOfInsuranceTableView]){
        NewsTopHeaderModel * model = self.infoOfInsuranceData[indexPath.row];
        if ([model.imglink isEqualToString:@""]) {
            return 120;
        }else{
            return 150;
        }
    }else{
        NewsTopHeaderModel * model = self.carExperienceData[indexPath.row];
        if (model.imglink_3.length != 0) {
            return 160;
        }else{
            return 150;
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailViewController * detailVC = [DetailViewController new];
    NewsTopHeaderModel * model = nil;
    if ([tableView isEqual:_topHeaderTableView]) {
        model = self.topHeadersData[indexPath.row];
        
    }else if([tableView isEqual:_infoOfInsuranceTableView]){
        model = self.infoOfInsuranceData[indexPath.row];
        
    }else{
        model = self.carExperienceData[indexPath.row];
        
    }
    
    [detailVC setHidesBottomBarWhenPushed:YES];
    detailVC.url = model.url;
    [self.navigationController pushViewController:detailVC animated:YES];

}

#pragma mark - UITableViewDataSource


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (tableView.tag) {
        case NEWS_TOPHEADER_TAG:
            return self.topHeadersData.count;
            break;
        case NEWS_INFOOFINSURE_TAG:
            return self.infoOfInsuranceData.count;
            break;
        case NEWS_CAREXPERIENCE_TAG:
            return self.carExperienceData.count;
            break;
        default:
        {
            NSException * exc = [NSException exceptionWithName:@"Error:" reason:@"没有这个Tag" userInfo:nil];
            @throw exc;
        }
            break;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == NEWS_TOPHEADER_TAG) {
        //车闻头条
        NewsTopHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID1 forIndexPath:indexPath];
        NewsTopHeaderModel * model = self.topHeadersData[indexPath.row];
        cell.model = model;
        return cell;
    }else if (tableView.tag == NEWS_INFOOFINSURE_TAG) {
        //车险讯息
        NewsTopHeaderModel * model = self.infoOfInsuranceData[indexPath.row];
        if ([model.imglink isEqualToString:@""]) {
            NewsInfoViewCellNoImg * cell = [tableView dequeueReusableCellWithIdentifier:reuseID3];
            cell.model = model;
            return cell;
        }else{
            NewsInfoViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID2];
            cell.model = model;
            return cell;
        }
    }else {
        //用车经验
        NewsTopHeaderModel * model = self.carExperienceData[indexPath.row];
        if (model.imglink_3.length != 0) {
            NewsExpViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID4];
            cell.model = model;
            return cell;
        }else{
            NewsInfoViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID5];
            cell.model = model;
            return cell;
        }
    }
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([scrollView isEqual:_mainScrollView]) {
        CGPoint offset = scrollView.contentOffset;
        NSInteger currentBtnIndex = offset.x / _mainScrollView.frame.size.width;
        [self changeBtnsSelectedToNo];
        UIButton *btn = self.btnsArr[currentBtnIndex];
        btn.selected = YES;
    }
}

#pragma mark - inherit Method


-(void)firstBtnPressed:(UIButton *)sender{
    
    [self changeBtnsSelectedToNo];
    sender.selected = YES;
    CGPoint offset = CGPointMake(0, -64);
    _mainScrollView.contentOffset = offset;
    
}

-(void)secondBtnPressed:(UIButton *)sender{
    if (self.infoOfInsuranceData.count == 0) {
        [self requestDataWithCurrentPage:1 andType:_titleManager.newsNaviRequestTitles[1] andIsFirst:NO];
    }
    [self.infoOfInsuranceTableView reloadData];
    [self changeBtnsSelectedToNo];
    sender.selected = YES;
    CGPoint offset = CGPointMake(_mainScrollView.frame.size.width, -64);
    _mainScrollView.contentOffset = offset;
    
}

-(void)thirdBtnPressed:(UIButton *)sender{
    if (self.carExperienceData.count == 0) {
        [self requestDataWithCurrentPage:1 andType:_titleManager.newsNaviRequestTitles[2] andIsFirst:NO];
    }
    [self.carExperienceTableView reloadData];
    [self changeBtnsSelectedToNo];
    sender.selected = YES;
    CGPoint offset = CGPointMake(_mainScrollView.frame.size.width * 2, -64);
    _mainScrollView.contentOffset = offset;
}

#pragma mark - other

-(void)firstLoad{
    [self requestDataWithCurrentPage:1 andType:_titleManager.newsNaviRequestTitles[0] andIsFirst:YES];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self requestDataWithCurrentPage:1 andType:_titleManager.newsNaviRequestTitles[1] andIsFirst:YES];
        [self requestDataWithCurrentPage:1 andType:_titleManager.newsNaviRequestTitles[2]andIsFirst:YES];
    });
    UIButton *btn = self.btnsArr[0];
    btn.selected = YES;
}

-(void)stopRefreshingIcon{
    
}

-(void)startRefreshingIcon{
    
}
@end
