//
//  NewsTopHeaderCell.m
//  my-Project-Car
//
//  Created by ntms on 16/1/30.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import "NewsTopHeaderCell.h"

@implementation NewsTopHeaderCell

- (void)awakeFromNib {
    // Initialization code
    //self.imgView.clipsToBounds = YES;
    //self.layer.cornerRadius = 10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(NewsTopHeaderModel *)model{
    
    _model = model;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:_model.imglink] placeholderImage:[UIImage imageNamed:@"NewsPlaceHolder"]];
    _titleLabel.text = _model.title;
    _mainLabel.text = _model.content168;
    _pastTimeLabel.text = [Utils pastTimeDescWithString:_model.date];
    _readLabel.text = [NSString stringWithFormat:@"阅读:%ld",_model.readarts];
    if (_model.readarts == 0) {
        _readLabel.hidden = YES;
    }
    _authorLabel.text = _model.author;

//    [self.imgView sd_setImageWithURL:[NSURL URLWithString:_model.imglink] placeholderImage:[UIImage imageNamed:@"NewsPlaceHolder"]];
//    self.titleLabel.text = _model.title;
//    self.mainLabel.text = _model.content168;
//    self.pastTimeLabel.text = _model.CTIME;
//    self.readLabel.text = [NSString stringWithFormat:@"阅读:%ld",_model.readarts];
//    self.authorLabel.text = _model.author;
}


@end
