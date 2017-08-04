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
@property (nonatomic,strong)UILabel *hotLabel;
@property (nonatomic,strong)UILabel *desLabel;
@property (nonatomic,strong)UIImageView *hotImageView;

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
    
    _hotLabel = [UILabel new];
    _hotLabel.font = [UIFont appFontFive];
    _hotLabel.textColor = [UIColor grayFontColor];
    [self.contentView addSubview:_hotLabel];
    
    _desLabel = [UILabel new];
    _desLabel.font = [UIFont appFontFour];
    _desLabel.numberOfLines = 0;
    _desLabel.textColor = [UIColor grayFontColor];
    [self.contentView addSubview:_desLabel];
    
    _hotImageView = [UIImageView new];
    _hotImageView.image = [UIImage imageNamed:@"activity_hot"];
    [self.contentView addSubview:_hotImageView];
    
    [_imageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.equalTo(kHeightIphone7(125));
    }];
    
    [_hotLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-kWidthIphone7(6));
        make.top.equalTo(_imageView.bottom).offset(kHeightIphone7(10));
        make.width.equalTo(kWidthIphone7(25));
        make.height.equalTo(kHeightIphone7(11));
    }];
    
    [_hotImageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_hotLabel.left);
        make.top.equalTo(_hotLabel.top);
        make.width.equalTo(kWidthIphone7(9));
        make.height.equalTo(kHeightIphone7(10));
    }];
    
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kWidthIphone7(6));
        make.top.equalTo(_imageView.bottom).offset(kHeightIphone7(5));
        make.right.equalTo(_hotImageView.left);
        make.height.equalTo(kHeightIphone7(16));
    }];
    
    [_desLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.left);
        make.top.equalTo(_titleLabel.bottom).offset(kHeightIphone7(3));
        make.centerX.equalTo(self.contentView.centerX);
        make.bottom.equalTo(self.contentView.bottom).offset(-kHeightIphone7(5));
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
    _hotLabel.text = model.hotStr;
    _desLabel.text = model.desStr;
}

@end
