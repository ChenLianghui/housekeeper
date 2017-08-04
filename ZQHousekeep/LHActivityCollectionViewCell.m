//
//  LHActivityCollectionViewCell.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/27.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHActivityCollectionViewCell.h"

@interface LHActivityCollectionViewCell ()

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *likeLabel;
@property (nonatomic,strong)UILabel *joinLabel;
@property (nonatomic,strong)UIImageView *likeImageView;
@property (nonatomic,strong)UIImageView *joinImageView;

@end

@implementation LHActivityCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createSubViews];
        [LHUtils addShadowWithView:self];
    }
    return self;
}

- (void)createSubViews{
    _imageView = [UIImageView new];
    
    [self.contentView addSubview:_imageView];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont appFontFour];
    _titleLabel.textColor = [UIColor grayFontColor];
    [self.contentView addSubview:_titleLabel];
    
    _likeLabel = [UILabel new];
    _likeLabel.font = [UIFont appFontFive];
    _likeLabel.textColor = [UIColor grayFontColor];
    [self.contentView addSubview:_likeLabel];
    
    _joinLabel = [UILabel new];
    _joinLabel.font = [UIFont appFontFive];
    _joinLabel.textColor = [UIColor grayFontColor];
    [self.contentView addSubview:_joinLabel];
    
    _likeImageView = [UIImageView new];
    _likeImageView.image = [UIImage imageNamed:@"like1_gray"];
    [self.contentView addSubview:_likeImageView];
    
    _joinImageView = [UIImageView new];
    _joinImageView.image = [UIImage imageNamed:@"join1_gray"];
    [self.contentView addSubview:_joinImageView];
    
    [_imageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.equalTo(kHeightIphone7(150));
    }];
    
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kWidthIphone7(6));
        make.top.equalTo(_imageView.bottom).offset(kHeightIphone7(5));
        make.right.equalTo(-kWidthIphone7(6));
        make.height.equalTo(kHeightIphone7(16));
    }];
    
    [_likeImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.left);
        make.top.equalTo(_titleLabel.bottom).offset(kHeightIphone7(5));
        make.width.equalTo(kWidthIphone7(9));
        make.height.equalTo(kHeightIphone7(8));
    }];
    
    [_likeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_likeImageView.right).offset(kWidthIphone7(4));
        make.top.height.equalTo(_likeImageView);
        make.width.equalTo(kWidthIphone7(30));
    }];
    
    [_joinImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_likeLabel.right).offset(kWidthIphone7(5));
        make.top.height.equalTo(_likeImageView);
        make.width.equalTo(kWidthIphone7(5));
    }];
    
    [_joinLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_joinImageView.right).offset(kWidthIphone7(4));
        make.width.top.height.equalTo(_likeLabel);
    }];
    
    [self layoutIfNeeded];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_imageView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(kWidthIphone7(8), kHeightIphone7(8))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _imageView.bounds;
    maskLayer.path = maskPath.CGPath;
    _imageView.layer.mask = maskLayer;
}

- (void)setModel:(LHActivityModel *)model{
    _model = model;
    _imageView.image = [UIImage imageNamed:model.imageName];
    _titleLabel.text = model.titleStr;
    _likeLabel.text = model.likeStr;
    _joinLabel.text = model.joinStr;
}

@end
