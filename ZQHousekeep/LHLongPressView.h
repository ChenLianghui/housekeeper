//
//  LHLongPressView.h
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/27.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHLongPressView : UIView

@property (nonatomic,copy)NSArray *imageNameArray;

- (instancetype)initWithFrame:(CGRect)frame andImageArray:(NSArray *)array;

@end
