//
//  LHSignScrollView.h
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/22.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickSecondTableviewBlock)();

@interface LHSignScrollView : UIScrollView

@property (nonatomic,strong)NSIndexPath *currentIndexPath1;
@property (nonatomic,strong)NSIndexPath *currentIndexPath2;
@property (nonatomic,strong)NSIndexPath *currentIndexPath3;
@property (nonatomic,copy) ClickSecondTableviewBlock block;

@end
