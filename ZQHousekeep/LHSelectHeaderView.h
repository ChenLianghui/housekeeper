//
//  LHSelectHeaderView.h
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/7/24.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectBlock)(NSInteger tag);

@interface LHSelectHeaderView : UIView

@property (nonatomic,copy)NSArray *titleArray;
@property (nonatomic,copy)selectBlock selectBlock;

- (instancetype)initWithFrame:(CGRect)frame andTitleArray:(NSArray *)titleArray;


@end
