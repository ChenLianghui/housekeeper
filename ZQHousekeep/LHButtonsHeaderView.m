//
//  LHButtonsHeaderView.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/22.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHButtonsHeaderView.h"

@interface LHButtonsHeaderView ()

@property (nonatomic,strong)UIButton *currentButton;

@end

@implementation LHButtonsHeaderView

- (instancetype)init{
    if (self = [super init]) {
        _currentIndex = 0;
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeightIphone7(39), self.bounds.size.width, kHeightIphone7(1))];
        lineView.backgroundColor = [UIColor grayLineColor];
        [self addSubview:lineView];
    }
    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        _currentIndex = 0;
//        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeightIphone7(39), self.bounds.size.width, kHeightIphone7(1))];
//        lineView.backgroundColor = [UIColor grayLineColor];
//        [self addSubview:lineView];
//    }
//    return self;
//}


- (void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    for (int i = 0; i < _titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*self.bounds.size.width/3.0, 0, self.bounds.size.width/3.0, kHeightIphone7(39));
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayFontColor] forState:UIControlStateNormal];
        button.tag = 50+i;
        if (i == 0) {
            _currentButton = button;
            [button setTitleColor:[UIColor appThemeColor] forState:UIControlStateNormal];
        }
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
//        [button makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.width).multipliedBy(i/_titleArray.count);
//            make.top.equalTo(self.top);
//            make.width.equalTo(self.width).dividedBy(_titleArray.count);
//            make.height.equalTo(kHeightIphone7(39));
//        }];
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex{
    [_currentButton setTitleColor:[UIColor grayFontColor] forState:UIControlStateNormal];
    UIButton *button = (UIButton *)[self viewWithTag:50+currentIndex];
    [button setTitleColor:[UIColor appThemeColor] forState:UIControlStateNormal];
    _currentButton = button;
}

- (void)buttonClicked:(UIButton *)button{
    [_currentButton setTitleColor:[UIColor grayFontColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor appThemeColor] forState:UIControlStateNormal];
    _currentButton = button;
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonClickedWithIndex:)]) {
        [self.delegate buttonClickedWithIndex:button.tag-50];
    }
}

@end
