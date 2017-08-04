//
//  LHHomeMenuView.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/26.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHHomeMenuView.h"
#import "UIButton+ImageTitleSpacing.h"

#define kMenuWidth self.bounds.size.width/4
#define kMenuHeight self.bounds.size.height/2

@interface LHHomeMenuView ()

@property (nonatomic,copy)NSArray *imageNameArray;
@property (nonatomic,copy)NSArray *titleArray;

@end

@implementation LHHomeMenuView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _imageNameArray = @[@"menu",@"menu",@"menu",@"menu",@"menu",@"menu",@"menu",@"menu"];
        _titleArray = @[@"repair",@"visitor",@"complaints",@"appointment",@"express",@"pet",@"washing",@"order"];
        self.backgroundColor = [UIColor whiteColor];
        [self addSubViews];
        
    }
    return self;
}

- (void)addSubViews{
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 4; j++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(kMenuWidth*j, kMenuHeight*i, kMenuWidth, kMenuHeight);
            [button setTitle:_titleArray[i*4+j] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont appFontThree];
            [button setImage:[UIImage imageNamed:_imageNameArray[4*i+j]] forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor grayIconColor] forState:UIControlStateNormal];
            button.tag = 100+4*i+j;
            [button addTarget:self action:@selector(buttonCLicked:) forControlEvents:UIControlEventTouchUpInside];
            [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:kHeightIphone7(5)];
            [self addSubview:button];
        }
    }
}

- (void)buttonCLicked:(UIButton *)button{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ClickedMenuWithTheTag:)]) {
        [self.delegate ClickedMenuWithTheTag:button.tag-100];
    }
}

@end
