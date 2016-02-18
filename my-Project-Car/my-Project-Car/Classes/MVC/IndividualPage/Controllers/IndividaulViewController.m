//
//  IndividaulViewController.m
//  my-Project-Car
//
//  Created by ntms on 16/2/3.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import "IndividaulViewController.h"

@interface IndividaulViewController ()<UITableViewDelegate,UITableViewDataSource>

/**
 *  表格视图
 */
@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)NSArray * dataArray;

@end

@implementation IndividaulViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
    self.dataArray = @[@"清除缓存",@"评分",@"关于版本"];
    
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
    _naviTitleLabel.text = @"我的汽车堂";
    CGSize size = [_naviTitleLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:18]}];
    _naviTitleLabel.frame =CGRectMake(0, 0, size.width, size.height);
    _naviTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = _naviTitleLabel;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_SIZE.width, kSCREEN_SIZE.height - 64- 49)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}


#pragma mark - UITableViewDelegate


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            NSString * notice = [NSString stringWithFormat:@"请确定清除图片缓存:%.2f MB ",[Utils getSDWebImageCacheSize]];
            //UIAlertController * a = [UIAlertController alloc]
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"确定" message:notice preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"确定删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [Utils clearSDWebImageCache];
                // 0.25 秒后刷新视图
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView reloadData];
                        
                    });
                });
            }];
            [alertController addAction:action1];
            UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"取消删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertController addAction:action2];
            [self presentViewController:alertController animated:YES completion:nil];
        }
            break;
        case 1:
        {
            NSLog(@"评分");
        }
            break;
        default:
            break;
    }
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * individual_ReuseID1 = @"ruseID1";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:individual_ReuseID1];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:individual_ReuseID1];
    }
    cell.textLabel.font = [UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:14];
    cell.textLabel.text = _dataArray[indexPath.row];
    if (indexPath.row == 0) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f MB",[Utils getSDWebImageCacheSize]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (indexPath.row == 1){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.detailTextLabel.text = @"1.0.0";
    }
    return cell;
}

@end









