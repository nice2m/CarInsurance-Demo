//
//  NewsExpViewCell.h
//  my-Project-Car
//
//  Created by ntms on 16/1/30.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsTopHeaderModel.h"



@interface NewsExpViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *pastedTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *readLabel;

@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;

@property(nonatomic,strong)NewsTopHeaderModel * model;

@end
