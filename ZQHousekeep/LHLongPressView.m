//
//  LHLongPressView.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/27.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHLongPressView.h"

@implementation LHLongPressView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame andImageArray:(NSArray *)array{
    if (self = [super initWithFrame:frame]) {
        _imageNameArray = array;
        self.backgroundColor = [UIColor clearColor];
        [self createSubViews];
    }
    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        
//    }
//    return self;
//}

- (void)createSubViews{
    for (int i = 0; i < self.imageNameArray.count; i++) {
        UIImageView *imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:self.imageNameArray[i]];
        [LHUtils addShadowWithView:imageView];
        [self addSubview:imageView];
        double scale = pow(0.95, i);
        CGFloat height = kHeightIphone7(20)/self.imageNameArray.count;
        [imageView makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(self.bounds.size.width*scale, self.bounds.size.height-kHeightIphone7(20)*scale));
            make.centerX.equalTo(self.centerX);
            make.centerY.equalTo(self.centerY).offset(-kHeightIphone7(10)+height*i/2);
        }];
    }
}

@end
