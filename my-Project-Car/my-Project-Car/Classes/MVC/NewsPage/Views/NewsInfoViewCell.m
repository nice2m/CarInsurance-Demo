//
//  NewsInfoViewCell.m
//  my-Project-Car
//
//  Created by ntms on 16/1/30.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import "NewsInfoViewCell.h"

@implementation NewsInfoViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(NewsTopHeaderModel *)model{
    
    _model = model;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:_model.imglink] placeholderImage:[UIImage imageNamed:@"NewsPlaceHolder"]];
    _titleLabel.text = _model.title;
    //_mainLabel.text = _model.content168;
    _pastedTimeLabel.text = [Utils pastTimeDescWithString:_model.date];
    _readLabel.text = [NSString stringWithFormat:@"%ld 人阅读",_model.readarts];
    if (_model.readarts == 0) {
        _readLabel.hidden = YES;
    }
}

@end
