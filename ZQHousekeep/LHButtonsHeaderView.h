//
//  LHButtonsHeaderView.h
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/22.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LHButtonsHeaderViewDelegate <NSObject>

- (void)buttonClickedWithIndex:(NSInteger )index;

@end

@interface LHButtonsHeaderView : UIView

@property (nonatomic,copy)NSArray *titleArray;
@property (nonatomic,assign)NSInteger currentIndex;
@property (nonatomic,weak)id<LHButtonsHeaderViewDelegate> delegate;

@end
