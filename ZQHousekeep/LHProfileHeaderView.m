//
//  LHProfileHeaderView.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/29.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHProfileHeaderView.h"

@interface LHProfileHeaderView ()

@property (nonatomic,strong)UILabel *titleLabel1;
@property (nonatomic,strong)UILabel *titleLabel2;
@property (nonatomic,strong)UILabel *titleLabel3;

@end

@implementation LHProfileHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createSubViews];
        self.currentIndex = 0;
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (void)createSubViews{
    UIView *whiteView = [UIView new];
    whiteView.backgroundColor = [UIColor whiteColor];
    [LHUtils addShadowWithView:whiteView];
    [self addSubview:whiteView];
    
    _imageView = [[UIImageView alloc] init];
    _imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeaderView:)];
    [_imageView addGestureRecognizer:tap];
    [self insertSubview:_imageView aboveSubview:whiteView];
    
    _usernameLabel = [UILabel new];
    _usernameLabel.font = [UIFont appFontFour];
    _usernameLabel.textColor = [UIColor blackColor];
    _usernameLabel.textAlignment = NSTextAlignmentCenter;
    [whiteView addSubview:_usernameLabel];
    
    [whiteView makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.top.equalTo(self.top).offset(kWidthIphone7(32));
    }];
    
    [_imageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(self);
        make.width.equalTo(kWidthIphone7(64));
        make.height.equalTo(kWidthIphone7(64));
    }];
    
    [_usernameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_imageView.centerX);
        make.top.equalTo(_imageView.bottom);
        make.width.equalTo(kWidthIphone7(150));
        make.height.equalTo(kHeightIphone7(20));
    }];
    
    for (int i = 0; i < 3; i++) {
        UIView *buttonView = [UIView new];
        buttonView.backgroundColor = [UIColor whiteColor];
        buttonView.tag = 20+i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClicked:)];
        [buttonView addGestureRecognizer:tap];
        [whiteView addSubview:buttonView];
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.textColor = [UIColor grayFontColor];
        titleLabel.font = [UIFont appFontFour];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [buttonView addSubview:titleLabel];
        
        UILabel *numberLabel = [UILabel new];
        numberLabel.textColor = [UIColor blackColor];
        numberLabel.font = [UIFont appFontTwo];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        [buttonView addSubview:numberLabel];
        
        CGFloat width = kWidthIphone7(90);
        CGFloat margin = (self.bounds.size.width-kWidthIphone7(8)*2-width*3)/2;
        
        [buttonView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(kWidthIphone7(8)+(width+margin)*i);
            make.top.equalTo(_usernameLabel.bottom).offset(kHeightIphone7(10));
            make.width.equalTo(width);
            make.height.equalTo(kHeightIphone7(40));
        }];
        
        [numberLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(buttonView);
            make.height.equalTo(kHeightIphone7(20));
        }];
        
        [titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(buttonView);
            make.top.equalTo(numberLabel.bottom);
            make.height.equalTo(numberLabel);
        }];
        
        switch (i) {
            case 0:
                _activityLabel = numberLabel;
                titleLabel.text = @"activities";
                _titleLabel1 = titleLabel;
                break;
            case 1:
                _menberLabel = numberLabel;
                titleLabel.text = @"members";
                _titleLabel2 = titleLabel;
                break;
            case 2:
                _visitorLabel = numberLabel;
                titleLabel.text = @"today visitors";
                _titleLabel3 = titleLabel;
                break;
            default:
                break;
        }
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    UIImage *image = [UIImage imageNamed:@"headIcon"];
    
    _imageView.image = [image roundImageWithCornerRadius:image.size.width/2];
    [LHUtils createSmallIconHeaderImageWithImageView:_imageView andImageName:@"headAdd"];
    
}

- (void)tapClicked:(UITapGestureRecognizer *)tap{
    UIView *view = tap.view;
    switch (view.tag-20) {
        case 0:
            self.currentIndex = 0;
            break;
        case 1:
            self.currentIndex = 1;
            break;
        case 2:
            self.currentIndex = 2;
            break;
        default:
            break;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickItemWithIndex:)]) {
        [self.delegate didClickItemWithIndex:view.tag-20];
    }
}

- (void)tapHeaderView:(UITapGestureRecognizer *)tap{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickHeaderView)]) {
        [self.delegate didClickHeaderView];
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    if (_currentIndex == 0) {
        _titleLabel1.textColor = [UIColor appThemeColor];
        _activityLabel.textColor = [UIColor appThemeColor];
        _titleLabel2.textColor = [UIColor grayFontColor];
        _menberLabel.textColor = [UIColor blackColor];
        _titleLabel3.textColor = [UIColor grayFontColor];
        _visitorLabel.textColor = [UIColor blackColor];
    }else if (_currentIndex == 1){
        _titleLabel1.textColor = [UIColor grayFontColor];
        _activityLabel.textColor = [UIColor blackColor];
        _titleLabel2.textColor = [UIColor appThemeColor];
        _menberLabel.textColor = [UIColor appThemeColor];
        _titleLabel3.textColor = [UIColor grayFontColor];
        _visitorLabel.textColor = [UIColor blackColor];
    }else{
        _titleLabel1.textColor = [UIColor grayFontColor];
        _activityLabel.textColor = [UIColor blackColor];
        _titleLabel2.textColor = [UIColor grayFontColor];
        _menberLabel.textColor = [UIColor blackColor];
        _titleLabel3.textColor = [UIColor appThemeColor];
        _visitorLabel.textColor = [UIColor appThemeColor];
    }
}

@end
