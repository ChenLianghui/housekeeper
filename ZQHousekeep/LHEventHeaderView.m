//
//  LHEventHeaderView.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/28.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHEventHeaderView.h"
#import "UIButton+ImageTitleSpacing.h"

@interface LHEventHeaderView ()

@property (nonatomic,strong)UILabel *likeLabel;
@property (nonatomic,strong)UIButton *likeButton;
@property (nonatomic,strong)UIButton *joinButton;
@property (nonatomic,strong)UILabel *timeLabel;

@end

@implementation LHEventHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createSubViews];
        [LHUtils addShadowWithView:self];
    }
    return self;
}

- (void)createSubViews{
    _likeLabel = [UILabel new];
    _likeLabel.textColor = [UIColor grayFontColor];
    _likeLabel.font = [UIFont appFontThree];
    _likeLabel.text = @"0 people like";
    _likeLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_likeLabel];
    
    _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_likeButton setImage:[UIImage imageNamed:@"like2_gray"] forState:UIControlStateNormal];
    [_likeButton setTitle:@"like" forState:UIControlStateNormal];
    [_likeButton setTitleColor:[UIColor grayFontColor] forState:UIControlStateNormal];
    [_likeButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:2.0];
    [_likeButton addTarget:self action:@selector(likeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_likeButton];
    
    _joinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_joinButton setImage:[UIImage imageNamed:@"join2_gray"] forState:UIControlStateNormal];
    [_joinButton setTitle:@"join" forState:UIControlStateNormal];
    [_joinButton setTitleColor:[UIColor grayFontColor] forState:UIControlStateNormal];
    [_joinButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:2.0];
    [_joinButton addTarget:self action:@selector(joinButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_joinButton];
    
    _timeLabel = [UILabel new];
    _timeLabel.textColor = [UIColor grayFontColor];
    _timeLabel.font = [UIFont appFontThree];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.text = @"3 days ago";
    [self addSubview:_timeLabel];
    
    [_likeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-kWidthIphone7(5));
        make.width.equalTo(kWidthIphone7(150));
        make.height.equalTo(kHeightIphone7(20));
        make.top.equalTo(kHeightIphone7(20));
    }];
    
    [_likeButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kWidthIphone7(5));
        make.width.equalTo(kWidthIphone7(80));
        make.height.equalTo(kHeightIphone7(20));
        make.bottom.equalTo(-kHeightIphone7(10));
    }];
    
    [_joinButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_likeButton.right).offset(kWidthIphone7(5));
        make.width.height.bottom.equalTo(_likeButton);
    }];
    
    [_timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.height.width.equalTo(_likeLabel);
        make.bottom.equalTo(_joinButton.bottom);
    }];
    
}

- (void)likeButtonClicked:(UIButton *)button{
    button.selected = !button.selected;
    if (button.selected) {
        [button setImage:[UIImage imageNamed:@"like2_red"] forState:UIControlStateNormal];
    }else{
        [button setImage:[UIImage imageNamed:@"like2_gray"] forState:UIControlStateNormal];
    }
}

- (void)joinButtonClicked:(UIButton *)button{
    button.selected = !button.selected;
    if (button.selected) {
        [button setImage:[UIImage imageNamed:@"join2_green"] forState:UIControlStateNormal];
    }else{
        [button setImage:[UIImage imageNamed:@"join2_gray"] forState:UIControlStateNormal];
    }
    
}

- (void)setCurrentNumber:(int)currentNumber{
    _currentNumber = currentNumber;
    _likeLabel.text = [NSString stringWithFormat:@"%d people like",currentNumber];
    if (currentNumber>0) {
        
    }
}

@end
