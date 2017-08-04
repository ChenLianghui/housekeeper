//
//  LHAreaHeaderView.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/22.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHAreaHeaderView.h"

@implementation LHAreaHeaderView

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [LHUtils addShadowWithView:self];
        [self createSubView];
    }
    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        [self createSubView];
//    }
//    return self;
//}

- (void)createSubView{
    _titleLabel = [UILabel new];
    _titleLabel.textColor = [UIColor appThemeColor];
    _titleLabel.font = [UIFont appFontTwo];
    [self addSubview:_titleLabel];
    
//    UIView *lineView = [UIView new];
//    lineView.backgroundColor = [UIColor grayLineColor];
//    [self addSubview:lineView];
//    
//    _tableView = [UITableView new];
//    _tableView.rowHeight = kHeightIphone7(40);
//    [self addSubview:_tableView];
    
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kBorderMargin);
        make.top.equalTo(kHeightIphone7(10));
        make.height.equalTo(kHeightIphone7(20));
        make.width.equalTo(kWidthIphone7(150));
    }];
}


@end
