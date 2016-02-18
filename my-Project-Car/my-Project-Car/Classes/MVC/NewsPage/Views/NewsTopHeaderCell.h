//
//  NewsTopHeaderCell.h
//  my-Project-Car
//
//  Created by ntms on 16/1/30.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NewsTopHeaderModel.h"

@interface NewsTopHeaderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *mainLabel;

@property (weak, nonatomic) IBOutlet UILabel *pastTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *readLabel;

@property (weak, nonatomic) IBOutlet UILabel *authorLabel;

@property(nonatomic,strong)NewsTopHeaderModel * model;

@end

