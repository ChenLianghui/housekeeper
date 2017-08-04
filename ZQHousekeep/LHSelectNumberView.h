//
//  LHSelectNumberView.h
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/7/4.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  LHSelectNumberViewDelegate <NSObject>

@optional
- (void)hadReachedTheLowestNumber;
- (void)hadReachedTheHighestNumber;

@end

@interface LHSelectNumberView : UIView

@property (nonatomic,assign)int minNumber;
@property (nonatomic,assign)int maxNumber;
@property (nonatomic,weak)id<LHSelectNumberViewDelegate> delegate;

+ (instancetype)createNumberViewWithMinNumber:(int)minNumber maxNumbder:(int)maxNumber;

@end
