//
//  NewsExpViewCell.m
//  my-Project-Car
//
//  Created by ntms on 16/1/30.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import "NewsExpViewCell.h"


@implementation NewsExpViewCell


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


-(void)setModel:(NewsTopHeaderModel *)model{
//    self.layer.cornerRadius
    _model = model;
    _titleLabel.text = _model.title;
    [_img1 sd_setImageWithURL:[NSURL URLWithString:_model.imglink_1] placeholderImage:[UIImage imageNamed:@"NewsPlaceHolder"]];
    [_img2 sd_setImageWithURL:[NSURL URLWithString:_model.imglink_2] placeholderImage:[UIImage imageNamed:@"NewsPlaceHolder"]];
    [_img3 sd_setImageWithURL:[NSURL URLWithString:_model.imglink_3] placeholderImage:[UIImage imageNamed:@"NewsPlaceHolder"]];
    _pastedTimeLabel.text = [Utils pastTimeDescWithString:_model.date];
    _readLabel.text = [NSString stringWithFormat:@"%ld 人阅读",_model.readarts];
    if (_model.readarts == 0) {
        _readLabel.hidden = YES;
    }
    
}


@end
