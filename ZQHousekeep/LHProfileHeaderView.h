//
//  LHProfileHeaderView.h
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/29.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LHProfileHeaderViewDelegate <NSObject>

- (void)didClickHeaderView;
- (void)didClickItemWithIndex:(NSInteger )index;

@end

@interface LHProfileHeaderView : UIView

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *usernameLabel;
@property (nonatomic,strong)UILabel *activityLabel;//活动数量
@property (nonatomic,strong)UILabel *menberLabel;//家庭成员数量
@property (nonatomic,strong)UILabel *visitorLabel;//今天预约到访人数
@property (nonatomic,assign)NSInteger currentIndex;

@property (nonatomic,weak)id <LHProfileHeaderViewDelegate> delegate;

@end
