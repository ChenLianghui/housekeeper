//
//  LHHomeMenuView.h
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/26.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LHHomeMenuViewDelegate <NSObject>

- (void)ClickedMenuWithTheTag:(NSInteger)tag;

@end

@interface LHHomeMenuView : UIView

@property (nonatomic,weak)id<LHHomeMenuViewDelegate> delegate;

@end


