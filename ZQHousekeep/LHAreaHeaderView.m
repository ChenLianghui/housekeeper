//
//  LHTabelHeaderView.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/22.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHAreaHeaderView.h"

@implementation LHAreaHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createSubView];
        [LHUtils addShadowWithView:self];
    }
    return self;
}

- (void)createSubView{
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = self.titleStr;
    titleLabel.textColor = [UIColor appThemeColor];
    titleLabel.font = [UIFont appFontTwo];
    [self addSubview:titleLabel];
    
//    UIView *lineView = [UIView new];
//    lineView.backgroundColor = [UIColor grayLineColor];
//    [self addSubview:lineView];
//    
//    _tableView = [UITableView new];
//    _tableView.rowHeight = kHeightIphone7(40);
//    [self addSubview:_tableView];
    
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kBorderMargin);
        make.top.equalTo(kHeightIphone7(10));
        make.height.equalTo(kHeightIphone7(20));
        make.width.equalTo(kWidthIphone7(150));
    }];
}


@end
