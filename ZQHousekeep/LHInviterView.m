//
//  LHInviterView.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/7/5.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHInviterView.h"


@implementation LHInviterView

- (instancetype)init{
    if (self = [super init]) {
        [self createSubViews];
    }
    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        [self createSubViews];
//    }
//    return self;
//}

- (void)createSubViews{
    _iconImageView = [UIImageView new];
    [self addSubview:_iconImageView];
    
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont appFontThree];
    _nameLabel.textColor = [UIColor grayFontColor];
    [self addSubview:_nameLabel];
    
    _addressLabel = [UILabel new];
    _addressLabel.font = [UIFont appFontThree];
    _addressLabel.textColor = [UIColor grayFontColor];
    _addressLabel.numberOfLines = 0;
    [self addSubview:_addressLabel];
    
    [_iconImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kCellContentMargin);
        make.top.equalTo(kHeightIphone7(50));
        make.width.equalTo(kWidthIphone7(40));
        make.height.equalTo(kWidthIphone7(40));
    }];
    
    [_nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImageView.right).offset(kWidthIphone7(20));
        make.top.equalTo(_iconImageView.top);
        make.right.equalTo(-kCellContentMargin);
        make.height.equalTo(kHeightIphone7(20));
    }];
    
    [_addressLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(_nameLabel);
        make.top.equalTo(_nameLabel.bottom);
    }];
}


@end
