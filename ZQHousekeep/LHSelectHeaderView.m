//
//  LHSelectHeaderView.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/7/24.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHSelectHeaderView.h"

@interface LHSelectHeaderView ()

@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)UIButton *selectedButton;

@end

@implementation LHSelectHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame andTitleArray:(NSArray *)titleArray{
    if (self = [super initWithFrame:frame]) {
        _titleArray = [NSArray array];
        _titleArray = titleArray;
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews{
    for (int i = 0; i < _titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 30+i;
        [button setTitle:_titleArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont appFontThree];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [button makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.bottom);
            make.width.equalTo(kWidthIphone7(100));
            make.height.equalTo(kHeightIphone7(30));
            make.centerX.equalTo(self.centerX).multipliedBy((2.0*i+1)/_titleArray.count);
        }];
        if (i == 0) {
            _selectedButton = button;
            [button setTitleColor:[UIColor appThemeColor] forState:UIControlStateNormal];
        }else{
            [button setTitleColor:[UIColor grayFontColor] forState:UIControlStateNormal];
        }
        
    }
    
    _lineView = [UIView new];
    _lineView.backgroundColor = [UIColor appThemeColor];
    [self addSubview:_lineView];
    
    [_lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_selectedButton.bottom).offset(-kHeightIphone7(2));
        make.height.equalTo(kHeightIphone7(2));
        make.width.equalTo(kWidthIphone7(20));
        make.centerX.equalTo(_selectedButton.centerX);
    }];
}

- (void)buttonClicked:(UIButton *)button{
    if (button == _selectedButton) {
        return;
    }else{
        if (self.selectBlock) {
            self.selectBlock(button.tag-30);
        }
        [button setTitleColor:[UIColor appThemeColor] forState:UIControlStateNormal];
        [_selectedButton setTitleColor:[UIColor grayFontColor] forState:UIControlStateNormal];
        _selectedButton = button;
//        [_lineView updateConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(_selectedButton.centerX);
//        }];
        [_lineView remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_selectedButton.bottom).offset(-kHeightIphone7(2));
            make.height.equalTo(kHeightIphone7(2));
            make.width.equalTo(kWidthIphone7(20));
            make.centerX.equalTo(_selectedButton.centerX);
        }];
        [_lineView setNeedsLayout];
        [_lineView layoutIfNeeded];
    }
}

@end
