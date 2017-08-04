//
//  LHHomeCollectionViewCell.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/26.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHHomeCollectionViewCell.h"

@interface LHHomeCollectionViewCell ()

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *numberLabel;

@end

@implementation LHHomeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [LHUtils addShadowWithView:self];
        self.backgroundColor = [UIColor whiteColor];
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews{
    _imageView = [UIImageView new];
    [self.contentView addSubview:_imageView];
    
    _titleLabel = [UILabel new];
    _titleLabel.textColor = [UIColor blackFontColor];
    _titleLabel.font = [UIFont appFontTwo];
    [self.contentView addSubview:_titleLabel];
    
    _numberLabel = [UILabel new];
    _numberLabel.textColor = [UIColor darkGrayFontColor];
    _numberLabel.font = [UIFont appFontTwo];
    [self.contentView addSubview:_numberLabel];
    
    [_numberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kWidthIphone7(9));
        make.bottom.equalTo(self.contentView.bottom).offset(-kHeightIphone7(10));
        make.height.equalTo(kHeightIphone7(20));
        make.centerX.equalTo(self.contentView.centerX);
    }];
    
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_numberLabel.left);
        make.centerX.equalTo(_numberLabel.centerX);
        make.bottom.equalTo(_numberLabel.top).offset(-kHeightIphone7(10));
        make.height.equalTo(kHeightIphone7(20));
    }];
    
    [_imageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kWidthIphone7(9));
        make.top.equalTo(kHeightIphone7(9));
        make.centerX.equalTo(self.contentView.centerX);
        make.bottom.equalTo(_titleLabel.top).offset(-kHeightIphone7(10));
    }];
}

- (void)setModel:(LHHomeCollectionModel *)model{
    _model = model;
    UIImage *image = [UIImage imageNamed:model.imageName];
//    CGFloat height = image.size.height/(self.bounds.size.width-kWidthIphone7(9)*2);
//    [_imageView updateConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(height);
//    }];
    _imageView.image = image;
    _titleLabel.text = model.titleStr;
    _numberLabel.text = model.numberStr;
}

@end
