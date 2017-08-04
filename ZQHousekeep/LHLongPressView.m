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
    for (NSInteger i = self.imageNameArray.count-1; i >= 0; i--) {
        UIImageView *imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:self.imageNameArray[i]];
        imageView.userInteractionEnabled = YES;
        [LHUtils addShadowWithView:imageView];
        
        //添加拖动手势
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(doHandlePanAction:)];
        [imageView addGestureRecognizer:panGestureRecognizer];
        
        [self addSubview:imageView];
        double scale = pow(0.95, i);
        CGFloat height = kHeightIphone7(20)/(self.imageNameArray.count-1);
        [imageView makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(self.bounds.size.width*scale, self.bounds.size.height-kHeightIphone7(20)*scale));
            make.centerX.equalTo(self.centerX);
            make.centerY.equalTo(self.centerY).offset(-kHeightIphone7(10)+height*i/2);
        }];
    }
}

- (void)doHandlePanAction:(UIPanGestureRecognizer *)pan{
    CGPoint point = [pan translationInView:self];
    NSLog(@"x:%f,y:%f",point.x,point.y);
    pan.view.center = CGPointMake(pan.view.center.x+point.x, pan.view.center.y+point.y);
    [pan setTranslation:CGPointMake(0, 0) inView:self];
}

@end
